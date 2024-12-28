<template>
  <div class="items">
    <div class="item" v-for="item in toDo" :key="item.id">
      <input type="checkbox" :checked="item.isCompleted" @change="() => changeCompleted(item.id)" />
      <p v-if="!item.isEdit" :class="item.isCompleted ? 'line' : ''">{{ item.task }}</p>
      <form v-if="item.isEdit" @submit.prevent="(ev) => handleFormSubmit(ev, item.id)" class="editItems">
        <input type="text" :value="item.task" />
        <button><img src="@/assets/images/done.png" alt="done"></button>
      </form>
      <div class="items__btns">
        <button v-if="!item.isEdit" @click="() => editTask(item.id)"><img src="@/assets/images/edit.png" alt="edit"></button>
        <button @click="() => delItemTodo(item.id)"><img src="https://png.pngtree.com/png-vector/20220929/ourmid/pngtree-full-recycle-bin-icon-symbol-rubbish-red-vector-png-image_20010720.jpg" alt="edit"></button>
      </div>
    </div>
  </div>
</template>

<script setup>
const props = defineProps(["items"]);
const toDo = computed(() => props.items);
const emits = defineEmits(["change", "edit", "task", "deleteToDo"]);

const changeCompleted = (id) => {
  emits("change", id);
};

const editTask = (id) => {
  emits("edit", id);
};

const handleFormSubmit = async (ev, id) => {
  const newTask = ev.target[0].value;
  if (newTask.trim()) {
    emits("task", [newTask, id]);
  }
};

const delItemTodo = (id) => {
  emits("deleteToDo", id);
};
</script>

<style scoped>
.items {
  margin-top: 24px;
  overflow-y: scroll;
  scrollbar-color: #0d0714 #3e1671;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  max-width: 432px;
  height: 400px;
  row-gap: 5px;
}
.item {
  padding: 12px 8px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  gap: 8px;
  vertical-align: middle;
  border-radius: 8px;
  background-color: #15101c;
  font-size: 22px;
  text-transform: capitalize;
}
input[type="checkbox"] {
  width: 22px;
  height: 22px;
  accent-color: rgb(1, 77, 8);
}
input[type="checkbox"]:hover {
  accent-color: #15101c;
}
.line {
  text-decoration: line-through;
  text-decoration-color: #15101c;
  text-decoration-thickness: 2px;
}
p {
  font-size: 17px;
  font-weight: bold;
  text-transform: capitalize;
  color: #9e78cf;
}
.items__btns {
  display: flex;
  gap: 8px;
}
.items__btns > button{
  background-color: transparent;
}
.items__btns > button > img {
  width: 25px;
  height: 25px;
  border-radius: 24%;
}
.editItems{
    display: flex;
    gap: 8px;
    width: 150px;
    button{
        margin-left: 30px;

    }
    img{
        width: 23px;
        height: 23px;
    }
    input{
        outline: none;
        background-color: transparent;
        border: none;
        text-align: center;
        font-size: 18px;
        width: 150px;
        color: #9E78CF;
        border: 1px solid #3e1671;
        &::placeholder{
            color: #777777;
        }
    }
}
</style>
