module.exports = {
    preset: 'ts-jest',
    testEnvironment: 'node',
    moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
    collectCoverage: true,
    collectCoverageFrom: ['movierepository.ts'],
    coverageThreshold: {
    	global: {
      		branches: 50,
      		lines: 50,
   		},
    }
  };
  