import { glob } from 'astro/loaders';
import { defineCollection } from 'astro:content';

const aFewHarderProblems = defineCollection({
  loader: glob({
    base: '../',
    pattern: '+([0-9])+([A-Z]).typ',
  }),
});

const exercises = defineCollection({
  loader: glob({
    base: '../',
    pattern: '+([0-9]).+([.0-9]).typ',
  }),
});

const le14 = defineCollection({
  loader: glob({
    base: '../',
    pattern: 'Le14-+([.0-9]).typ',
  }),
});

const hatcher = defineCollection({
  loader: glob({
    base: '../',
    pattern: 'Hatcher-+([.0-9]).typ',
  }),
});

export const collections = { aFewHarderProblems, exercises, le14, hatcher };
