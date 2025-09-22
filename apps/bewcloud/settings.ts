import { Config, PartialDeep } from './lib/types.ts';

/** Check the Config type for all the possible options and instructions. */
const config: PartialDeep<Config> = {
  auth: {
    baseUrl: 'https://cloud.${DOMAIN}',
    allowSignups: false,
    enableEmailVerification: false,
    enableForeverSignup: false,
    enableMultiFactor: false,
    enableSingleSignOn: true,
    singleSignOnUrl: 'https://auth.${DOMAIN}',
    singleSignOnScopes: ['openid', 'email'],
    singleSignOnEmailAttribute: 'email',
  },
  files: {
    rootPath: 'data-files',
    allowPublicSharing: true,
  },
  core: {
    enabledApps: ['news', 'photos'], //, 'contacts', 'calendar'],
  },
  visuals: {
    title: 'bewCloud',
    description: '',
    helpEmail: '',
  },
  // contacts: {
  //   enableCardDavServer: true,
  //   cardDavUrl: 'http://radicale:5232',
  // },
  // calendar: {
  //   enableCalDavServer: true,
  //   calDavUrl: 'http://radicale:5232',
  // },
};

export default config;