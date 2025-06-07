import type { AstroIntegration, ContentEntryType, HookParameters } from 'astro';

// ref: https://github.com/withastro/astro/blob/c46210d8db9e88bd6b316be779809f0e44715030/packages/integrations/mdx/src/index.ts#L29-L53
type SetupHookParams = HookParameters<'astro:config:setup'> & {
  // `addPageExtension` and `contentEntryType` are not a public APIs
  // Add type defs here
  addPageExtension: (extension: string) => void;
  addContentEntryType: (contentEntryType: ContentEntryType) => void;
};

export default function typst(): AstroIntegration {
  return {
    name: 'astro-typst',
    hooks: {
      'astro:config:setup'(params) {
        const { addContentEntryType } = params as SetupHookParams;
        addContentEntryType({
          extensions: ['.typ'],
          getEntryInfo({ contents }) {
            return {
              data: {},
              rawData: '',
              body: contents,
              // astro will fill this
              slug: '',
            };
          },
        });
      },
    },
  };
}
