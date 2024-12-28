<template>
  <div class="to-do">
    <div class="to-do__container container">
      <h2>Title: {{ toDo.title }}</h2>
      <ToDoHeader @delete="deleteItem" :to-do-id="toDo.id" :items="toDo.item" @created="getNewItem" @search="searchItemToDo"/>
      <ToDoItems :items="toDo.item" @change="changeCompleteds" @edit="editTask" @task="editText" @deleteToDo="delItemToDos"  />
    </div>
  </div>
</template>

<script setup>
const route = useRoute();
const id = computed(() => route.params.id);
const toDos = ref({}); 
const toDo = ref({}); 
const originalItems = ref([]);

const getItem = async () => {
  let response = await fetch(`http://localhost:3005/toDos/${id.value}`);
  let result = await response.json();

  toDos.value = result; 
  toDo.value = { ...result, item: result.item.sort((a, b) => a.task.localeCompare(b.task)) }; 
  originalItems.value = [...result.item];
};
getItem();

const getNewItem = (arg) => {
  toDo.value.item.push(arg);
  originalItems.value.push(arg); 
};

const changeCompleteds = async (id) => {
  const updatedItems = toDo.value.item.map((el) => (el.id === id ? { ...el, isCompleted: !el.isCompleted } : el));

  await fetch(`http://localhost:3005/toDos/${toDo.value.id}`, {
    method: "PATCH",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      item: updatedItems,
    }),
  });

  toDo.value.item = updatedItems;
};

const editTask = async (id) => {
  const updatedItems = toDo.value.item.map((el) => (el.id === id ? { ...el, isEdit: !el.isEdit } : el));

  await fetch(`http://localhost:3005/toDos/${toDo.value.id}`, {
    method: "PATCH",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      item: updatedItems,
    }),
  });

  toDo.value.item = updatedItems;
};

const editText = async (arg) => {
  const updatedItems = toDo.value.item.map((el) => (el.id === arg[1] ? { ...el, task: arg[0], isEdit: false, isCompleted: false } : el));

  await fetch(`http://localhost:3005/toDos/${toDo.value.id}`, {
    method: "PATCH",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      item: updatedItems,
    }),
  });

  toDo.value.item = updatedItems;
};
const deleteItem = async () => {
  try {
    await fetch(`http://localhost:3005/toDos/${toDo.value.id}`, {
      method: "DELETE",
    });
    navigateTo("/");
  } catch (error) {
    console.error("Failed to delete the item:", error);
  }
};

const delItemToDos = async (id) => {
  const updatedItems = toDo.value.item.filter((el) => el.id !== id);

  await fetch(`http://localhost:3005/toDos/${toDo.value.id}`, {
    method: "PATCH",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      item: updatedItems,
    }),
  });

  toDo.value.item = updatedItems;
  originalItems.value = updatedItems; 
};

const searchItemToDo = (text) => {
  if (!text) {
    toDo.value.item = [...originalItems.value];
  } else {
    toDo.value.item = originalItems.value
      .filter((el) => el.task.toLowerCase().includes(text.toLowerCase()))
      .sort((a, b) => a.task.localeCompare(b.task));
  }
};
</script>

<style scoped>
.to-do {
  width: 100%;
  padding: 10px 20px;
  background-color: #0d0714;
  height: 740px;
}
.to-do__container {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  gap: 20px;
  margin-top: 58px;
}
h2{
  color: #9f9d9d;
}
</style>
