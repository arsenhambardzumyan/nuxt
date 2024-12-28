<template>
  <div class="del-modal" @click="closeAll">
    <div class="del-modal__container">
      <slot></slot>
      <button class="close-modal"><img src="https://static-00.iconduck.com/assets.00/close-icon-2048x2048-8uto7ebt.png" alt="" /></button>
    </div>
  </div>
</template>

<script setup>
const emits = defineEmits(["close-modal"]);

const closeAll = (ev) => {
  if (ev.target.classList.contains("del-modal") || ev.target.classList.contains("close-modal") || ev.target.localName === "img") {
    emits("close-modal");
  }
};
</script>

<style scoped>
.del-modal {
  width: 100%;
  position: fixed;
  left: 0;
  top: 0;
  background-color: rgb(128, 128, 128, 0.8);
  height: 100dvh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.del-modal__container {
  width: 310px;
  height: 300px;
  border: 1px solid black;
  border-radius: 22px;
  display: flex;
  justify-content: center;
  background-color: #0d0714;
  align-items: center;
  flex-direction: column;
  row-gap: 28px;
  position: relative;
}
.close-modal {
  top: 12px;
  right: 10px;
  position: absolute;
  background-color: white;
  border-radius: 100%;
  width: 30px;
  height: 30px;
}
.close-modal > img {
  width: 100%;
  height: 100%;
  border-radius: 100%;
}
p {
  color: #9f9d9d;
  font-size: 35px;
}
</style>
