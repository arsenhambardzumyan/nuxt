<template>
  <div class="to-do__btns">
    <NuxtLink to="/">Home</NuxtLink>
    <button @click="openMod">Delete</button>
    <Modal v-if="openModal" @closeModal="openMod">
      <p>Are you sure you want to delete ?</p>
      <div class="del-mod">
        <button @click="emits('delete')">Yes</button>
        <button @click="openMod">No</button>
      </div>
    </Modal>
    <button @click="() => (isSearch = !isSearch)">Search</button>
  </div>
  <form v-if="!isSearch" @submit.prevent="handleFormSubmit" class="to-do__header">
    <input type="text" placeholder="Add A New Task" />
    <svg stroke="currentColor" fill="#3e1671" stroke-width="0" viewBox="0 0 16 16" class="img-add" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M8 2a5.53 5.53 0 0 0-3.594 1.342c-.766.66-1.321 1.52-1.464 2.383C1.266 6.095 0 7.555 0 9.318 0 11.366 1.708 13 3.781 13h8.906C14.502 13 16 11.57 16 9.773c0-1.636-1.242-2.969-2.834-3.194C12.923 3.999 10.69 2 8 2zm.5 4v1.5H10a.5.5 0 0 1 0 1H8.5V10a.5.5 0 0 1-1 0V8.5H6a.5.5 0 0 1 0-1h1.5V6a.5.5 0 0 1 1 0z"></path></svg>
  </form>
  <input v-else type="text" @input="searchItem" placeholder="search Item" />
</template>

<script setup>
let openModal = ref(false);
const emits = defineEmits(["delete", "created", "search"]);
const props = defineProps(["toDoId", "items"]);
const toDoId = computed(() => props.toDoId);
const items = computed(() => props.items);
let isSearch = ref(false);

const openMod = () => {
  openModal.value = !openModal.value;
};

const handleFormSubmit = async (ev) => {
  const newTask = ev.target[0].value;

  let newToDo = {
    id: new Date().getTime().toString(),
    task: newTask,
    isCompleted: false,
    isEdit: false,
  };

  if (newTask.trim()) {
    fetch(`http://localhost:3005/toDos/${toDoId.value}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        item: [...items.value, newToDo],
      }),
    });
    emits("created", newToDo);
  }

  ev.target.reset();
};

const searchItem = (ev) => {
  emits("search", ev.target.value);
};
</script>

<style scoped>
.to-do__btns {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 10px;
  width: 100%;
  max-width: 423px;
  margin-top: 25px;
}
p{
  color: #9f9d9d;
  margin-bottom: 7px;
}
.del-mod{
  display: flex;
  gap: 12px;
  flex-direction: column;
  width: 100%;
  padding: 27px 20px;
  margin-top: 20px;
}
button,
a {
  color: #9f9d9d;
  padding: 8px 12px;
  border-radius: 7px;
  outline: none;
  transition: all 0.6s;
  background-color: #3e1671;
  &:hover {
    color: white;
    background-color: green;
    border: none;
  }
}
button {
  background-color: #3e1671;
  border: none;
  color: #9f9d9d;
  font-size: 14px;
  cursor: pointer;
}
.img-add{
  font-size: 45px;
}
.to-do__header {
  display: flex;
  width: 100%;
  justify-content: center;
  gap: 15px;
}
.to-do__header > input {
  padding: 8px 18px;
  text-transform: capitalize;
  font-weight: 700;
  font-size: 15px;
  width: 100%;
  max-width: 360px;
  height: 40px;
  background-color: transparent;
  border: 1px solid #3e1671;
  outline: none;
  border-radius: 8px;
  color: #d8d7d7;
}
.searchInput {
  padding: 8px 18px;
  text-transform: capitalize;
  font-weight: 700;
  font-size: 15px;
  background-color: transparent;
  border: 1px solid #3e1671;
  outline: none;
  border-radius: 8px;
  color: #d8d7d7;
}
input {
  padding: 8px 18px;
  text-transform: capitalize;
  font-weight: 700;
  font-size: 15px;
  background-color: transparent;
  border: 1px solid #3e1671;
  outline: none;
  border-radius: 8px;
  height: 40px;
  width: 100%;
  max-width: 414px;
  color: #d8d7d7;
  &::placeholder {
    color: #777777;
    opacity: 1;
  }
}
input::placeholder {
  color: #777777;
  opacity: 1;
}
.headerToDo > form > button {
  color: #3e1671;
  font-size: 14px;
  background-color: transparent;
  border-radius: 8px;
  outline: none;
  border: none;
}
</style>
