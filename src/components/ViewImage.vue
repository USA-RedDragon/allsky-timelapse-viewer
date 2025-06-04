<template>
  <div>
    <img :src="images[imageIndex[0]-1]" alt="Allsky camera image" />
    <Slider
        v-model="imageIndex"
        :max="images.length"
        :min="1"
        :step="1"
        class="mt-4" />
  </div>
</template>

<script lang="ts">
import axios from 'axios';

import { Slider } from '@/components/ui/slider'

export default {
  components: {
    Slider,
  },
  data: function() {
    return {
      images: [] as string[],
      imageIndex: [1],
      refreshTimer: null as ReturnType<typeof setInterval> | null,
    };
  },
  mounted() {
    // Refresh every 5 minutes
    this.fetchData();
    this.refreshTimer = setInterval(() => {
      this.fetchData();
    }, 5 * 60 * 1000);
  },
  unmounted() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer);
    }
  },
  methods: {
    fetchData() {
      axios.get(`https://s3.mcswain.dev/sfro-allsky/list.txt`)
        .then(response => {
          const newImages: string[] = [];
          for (const filename of response.data.split('\n')) {
            if (filename.trim()) {
              newImages.unshift(`https://s3.mcswain.dev/sfro-allsky/${filename}`);
            }
          }
          this.images = newImages;
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        })
        .finally(() => {
          console.log(`Images loaded:`, this.images);
        });
    }
  },
  computed: {},
};
</script>

<style scoped>
</style>
