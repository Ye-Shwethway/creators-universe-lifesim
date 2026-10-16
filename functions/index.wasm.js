// Cloudflare Pages Function for Godot WASM files that exceed Pages' 25 MiB per-file limit.
// Underlying chunks are immutable public game-engine bytes; no private assets are involved.
export async function onRequestGet(context) {
  const origin = new URL(context.request.url);
  const manifestUrl = new URL("/wasm-chunks/manifest.json", origin);
  const manifestResponse = await context.env.ASSETS.fetch(new Request(manifestUrl.toString()));
  if (!manifestResponse.ok) return new Response("WebAssembly manifest unavailable", { status: 503 });
  const manifest = await manifestResponse.json();
  if (!Array.isArray(manifest.parts) || manifest.parts.length < 1 || manifest.parts.length > 100)
    return new Response("Invalid WebAssembly manifest", { status: 500 });

  const body = new ReadableStream({
    async start(controller) {
      try {
        for (const part of manifest.parts) {
          if (!/^part-[0-9]{3}\.bin$/.test(part)) throw new Error("Invalid chunk");
          const url = new URL("/wasm-chunks/" + part, origin);
          const response = await context.env.ASSETS.fetch(new Request(url.toString()));
          if (!response.ok || !response.body) throw new Error("Missing WebAssembly chunk");
          const reader = response.body.getReader();
          while (true) {
            const { value, done } = await reader.read();
            if (done) break;
            controller.enqueue(value);
          }
        }
        controller.close();
      } catch (_) {
        controller.error(new Error("WebAssembly chunk delivery failed"));
      }
    }
  });
  return new Response(body, {
    headers: {
      "Content-Type": "application/wasm",
      "Cache-Control": "public, max-age=3600",
      "X-Content-Type-Options": "nosniff"
    }
  });
}
