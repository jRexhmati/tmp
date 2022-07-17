module.exports = {
  apps: [
    {
      cwd: './apps/auth',
      name: 'booston-services-auth',
      script: './dist/index.js',
      max_memory_restart: '1G',
    },
    {
      cwd: './apps/recruitment',
      name: 'booston-services-recruitment',
      script: './dist/index.js',
      max_memory_restart: '1G',
    },
    {
      cwd: './apps/settings',
      name: 'booston-services-settings',
      script: './dist/index.js',
      max_memory_restart: '1G',
    },
    {
      cwd: './apps/content',
      name: 'booston-services-content',
      script: './dist/index.js',
      max_memory_restart: '1G',
    },
    {
      cwd: './apps/workers',
      name: 'booston-services-workers',
      script: './dist/index.js',
      max_memory_restart: '1G',
    },
  ],
};
