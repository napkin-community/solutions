// @ts-check
import { defineConfig } from 'astro/config';
import typst from './integration/typst';

export default defineConfig({
  integrations: [typst()],
  vite: {
    ssr: {
      external: ['@myriaddreamin/typst-ts-node-compiler'],
    },
  },
});
