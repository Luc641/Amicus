module.exports = {
  extends: '@loopback/eslint-config',

  // See https://github.com/loopbackio/loopback-next/blob/e7fe40799fb01c46e2d818b1523400e79d723394/packages/eslint-config/eslintrc.js
  // Loopback's current eslint config is broken - Nils
  overrides: [{
    files: ['**/*.ts'],
    rules: {
      '@typescript-eslint/naming-convention': [
        'error',
        {
          selector: 'objectLiteralProperty',
          format: null,
          modifiers: ['requiresQuotes'],
        }
      ],
    },
  },
  ],
};
