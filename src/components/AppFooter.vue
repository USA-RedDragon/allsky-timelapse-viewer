<template>
  <div class="footer">
    <p>
      This project proudly open
      <a href="https://github.com/USA-RedDragon/allsky-timelapse-viewer" target="_blank"
        >source</a
      >
    </p>
    <p>Copyright &copy; 2025-{{ year }} Jacob McSwain</p>
    <p id="version">Version {{ version }}</p>
  </div>
</template>

<script lang="ts">
export default {
  data: function() {
    return {
      version: 'dev',
      year: new Date().getFullYear(),
    };
  },
  mounted() {
    if (import.meta.env.VITE_APP_VERSION !== undefined && import.meta.env.VITE_APP_COMMIT !== undefined) {
      this.version = `${import.meta.env.VITE_APP_VERSION} - ${import.meta.env.VITE_APP_COMMIT}`;
    }
  },
};
</script>

<style scoped>
.footer {
  text-align: center;
  display: block;
  padding: 1em;
  padding-bottom: 0;
  margin-bottom: 0;
  font-size: 0.8em;
}

.footer p#version {
  font-size: 0.8em;
  margin-top: 0;
  color: #666;
}
</style>
