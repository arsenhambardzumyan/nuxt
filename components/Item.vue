<template>
  <div class="home-item">
    <h2>Title: {{ toDo.title }}</h2>
    <img src="@/assets/images/todoimg.png" alt="todo" class="home-item__img">
    <div class="home-item__btns">
      <NuxtLink :to="'/toDo/' + toDo.id">Open</NuxtLink>
      <button @click="openMod">Delete</button>
    </div>
  </div>
  <Modal v-if="openModal" @closeModal="openMod">
    <p>Are you sure you want to delete ?</p>
    <div class="del-mod">
      <button @click="emits('item-id', toDo.id)">Yes</button>
      <button @click="openMod">No</button>
    </div>
  </Modal>
</template>

<script setup>
let openModal = ref(false);
const props = defineProps(["data"]);
const emits = defineEmits(["item-id"]);
const toDo = computed(() => props.data);

const openMod = () => {
  openModal.value = !openModal.value;
};
</script>

<style scoped>
.home-item {
  border: 1px solid black;
  width: 220px;
  text-align: center;
  padding: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  border-radius: 8px;
  background-color: #3e1671;
}
.home-item__img{
  width: 65px;
  height: 65px;
  border-radius: 22px;
}
p,
h2 {
  color: #9f9d9d;
  margin-bottom: 7px;
}
.home-item__btns {
  margin-top: 50px;
  display: flex;
  flex-direction: column;
  row-gap: 8px;
}
a {
  color: #0d0714;
  border: 1px solid white;
  padding: 8px 59px;
  border-radius: 22px;
  transition: all 0.6s;
  &:hover {
    color: white;
    background-color: green;
    border: none;
  }
}
.home-item__btns > button {
  color: rgb(15, 188, 249);
  border: 1px solid white;
  padding: 8px 26px;
  border-radius: 22px;
  cursor: pointer;
  color: red;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.6s;
  &:hover {
    color: white;
    background-color: red;
    border: none;
  }
}
p{
  margin-top: 45px;
}
.del-mod{
  display: flex;
  gap: 12px;
  flex-direction: column;
  width: 100%;
  padding: 27px 20px;
  margin-top: 20px;
}
.del-mod > button{
  padding: 8px;
  border-radius: 22px;
  background-color: #3e1671;
  color: white;
  font-size: 17px;
  font-weight: 600;
  transition: all .4s;
  &:hover{
    color: green;
  }
}
@media (max-width: 768px) {
  
  .home-item__btns {
    width: 100%;
    text-align: center;
    padding: 4px 20px;
  }
  a {
    width: 100%;
    text-align: center;
    padding: 8px;
  }
  .home-item__btns {
    margin-top: 18px;
    padding: 8px 20px;
  }
}
@media (max-width: 495px) {
  .home-item {
    width: 100%;
  }
}
</style>
