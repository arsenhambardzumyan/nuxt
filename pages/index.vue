<template>
  <div class="to-dos" :style="pageStyle">
    <div class="to-dos__container container">
      <h1>To Do Lists</h1>
      <div class="to-dos__form">
        <input type="text" @input="searchTitle" placeholder="Search To Do" />
        <button @click="openMod" class="to-dos__form-btn">
          <svg
            stroke="currentColor"
            fill="#3e1671"
            stroke-width="0"
            viewBox="0 0 16 16"
            class="img-adds"
            height="1em"
            width="1em"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M8 2a5.53 5.53 0 0 0-3.594 1.342c-.766.66-1.321 1.52-1.464 2.383C1.266 6.095 0 7.555 0 9.318 0 11.366 1.708 13 3.781 13h8.906C14.502 13 16 11.57 16 9.773c0-1.636-1.242-2.969-2.834-3.194C12.923 3.999 10.69 2 8 2zm.5 4v1.5H10a.5.5 0 0 1 0 1H8.5V10a.5.5 0 0 1-1 0V8.5H6a.5.5 0 0 1 0-1h1.5V6a.5.5 0 0 1 1 0z"
            ></path>
          </svg>
        </button>
      </div>
      <div class="to-do__items-block">
        <Item v-for="toDo in toDos" :key="toDo.id" :data="toDo" @itemId="deleteItem" />
      </div>
      <Modal v-if="openModal" @closeModal="openMod">
        <p>Write a caption !</p>
        <form @submit.prevent="handleFormSubmit">
          <input type="text" placeholder="text..." />
          <button>Create</button>
        </form>
      </Modal>
    </div>
  </div>
</template>

<script setup>
let toDos = ref([]);
let toDosData = ref([]);
let openModal = ref(false);
onMounted(() => {
  document.title = "To Do Lists";
});

const pageStyle = computed(() => {
  if (toDos.value.length < 1) {
    return { height: "100dvh" };
  } else {
    return { height: "auto" };
  }
});

const getToDos = async () => {
  let response = await fetch("http://localhost:3005/toDos");
  let result = await response.json();

  toDos.value = result.sort((a, b) => a.title.localeCompare(b.title));
  toDosData.value = result.sort((a, b) => a.title.localeCompare(b.title));

  return result;
};
getToDos();

const openMod = () => {
  openModal.value = !openModal.value;
};

const handleFormSubmit = async (ev) => {
  const newTitle = ev.target[0].value;

  let newToDo = {
    id: new Date().getTime().toString(),
    title: newTitle,
    item: [],
  };

  if (newTitle.trim()) {
    let isCotains = toDos.value.find((el) => el.title === newTitle);
    if (!isCotains) {
      fetch("http://localhost:3005/toDos", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(newToDo),
      });
      navigateTo(`/toDo/${newToDo.id}`);
      toDos.value.unshift(newToDo);
    }
  }
};

const deleteItem = async (id) => {
  try {
    await fetch(`http://localhost:3005/toDos/${id}`, {
      method: "DELETE",
    });

    toDos.value = toDos.value.filter((el) => el.id !== id);
  } catch (error) {
    console.error("Failed to delete the item:", error);
  }
};

const searchTitle = (ev) => {
  toDos.value = toDosData.value;
  toDos.value = toDos.value.filter((el) => el.title.includes(ev.target.value));
};
</script>

<style scoped>
.to-dos {
  width: 100%;
  padding: 40px 20px 105px;
  background-color: #0d0714;
}
.to-dos__container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  row-gap: 25px;
}
p,
h1 {
  color: #9f9d9d;
}
.img-adds {
  font-size: 54px;
}
.to-dos__form {
  width: 100%;
  display: flex;
  margin-top: 25px;
  align-items: center;
  gap: 5px;
  justify-content: center;
}
.to-dos__form > input {
  width: 100%;
  max-width: 500px;
  padding: 14px 16px;
  border-radius: 22px;
  outline: none;
  border: 1px solid #3e1671;
  color: #d8d7d7;
  font-weight: 700;
  font-size: 15px;
  background-color: transparent;
  font-family: "Franklin Gothic Medium", "Arial Narrow", Arial, sans-serif;
  letter-spacing: 1.8px;
  &::placeholder {
    color: #777777;
    opacity: 1;
  }
}
.to-dos__form-btn {
  background-color: transparent;
  border: none;
  width: 50px;
}
.to-dos__form-btn > img {
  width: 100%;
}
.to-do__items-block {
  margin-top: 80px;
  display: flex;
  justify-content: space-between;
  width: 100%;
  flex-wrap: wrap;
  gap: 15px;
}
form {
  display: flex;
  flex-direction: column;
  row-gap: 12px;
  margin-top: 58px;
}
input {
  width: 100%;
  max-width: 500px;
  padding: 8px 16px;
  border-radius: 8px;
  outline: none;
  border: 1px solid #3e1671;
  color: #d8d7d7;
  font-weight: 700;
  font-size: 15px;
  background-color: transparent;
  font-family: "Franklin Gothic Medium", "Arial Narrow", Arial, sans-serif;
  letter-spacing: 1.8px;
  &::placeholder {
    color: #777777;
    opacity: 1;
  }
}
button {
  width: 100%;
  padding: 8px 16px;
  border-radius: 22px;
  color: #3e1671;
}
@media (max-width: 768px) {
  .to-dos__form-btn {
    width: 20%;
  }
}
</style>
