<template>
  <Card>
    <CardHeader>
      <CardTitle>SFRO Allsky Timelapse</CardTitle>
    </CardHeader>
    <CardContent>
      <ViewImage />
    </CardContent>
  </Card>
</template>

<script lang="ts">
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';

import ViewImage from '@/components/ViewImage.vue';

export default {
  props: {},
  components: {
    Card,
    CardContent,
    CardHeader,
    CardTitle,
    ViewImage,
  },
  data: function() {
    return {};
  },
  mounted() {},
  unmounted() {},
  methods: {},
  computed: {},
};
</script>

<style scoped>
</style>
