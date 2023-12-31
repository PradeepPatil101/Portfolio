import { browser, Config } from 'protractor';

export let config: Config = {

  seleniumAddress: 'http://127.0.0.1:4444/wd/hub',

  SELENIUM_PROMISE_MANAGER: false,

  capabilities: {
    browserName: 'chrome'
  },

  framework: 'custom',
  frameworkPath: require.resolve('protractor-cucumber-framework'),

  specs: [
    '../../features/*.feature'
  ],

  onPrepare: () => {
    browser.manage().timeouts().implicitlyWait(10000);
    browser.ignoreSynchronization = true;
    browser.manage().window().maximize();

  },
  cucumberOpts: {
    compiler: "ts:ts-node/register",
    strict: true,
    require: ['../../stepdefinitions/*.ts'],
    timeout: 10000,
  }
};