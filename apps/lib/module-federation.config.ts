import { ModuleFederationConfig } from '@nx/module-federation';
const config: ModuleFederationConfig = {
  name: 'lib',
  exposes: {
    './Module': './src/remote-entry.ts',
    './lib': '../../hello/src/index.ts',
  },
};
/**
 * Nx requires a default export of the config to allow correct resolution of the module federation graph.
 **/
export default config;
