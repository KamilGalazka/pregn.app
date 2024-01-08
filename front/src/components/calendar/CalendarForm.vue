<script setup>
import BasicButton from "@/components/BasicButton.vue";
import { computed, ref, defineProps, defineEmits } from "vue";
import axios from "axios";
import { useStore } from "@/stores/store";
import routes from "@/helpers/routes";

const props = defineProps({
  date: Date,
  formType: String,
  convertedDate: String,
  title: String,
  text: String,
  priority: Number,
  noteId: Number,
});

const emit = defineEmits(["refreshCalendar"]);

const store = useStore();
const noteTitle = ref("");
const noteText = ref("");
const notePriority = ref(2);

const noteDate = computed(() => {
  const day = props.date.getDate();
  const month = props.date.getMonth() + 1;
  const year = props.date.getFullYear();

  return `${day}/${month}/${year}`;
});

const isFormForNewNote = computed(() => {
  return props.formType === "create";
});

const fillValueForEditForm = () => {
  if (!isFormForNewNote.value) {
    noteTitle.value = props.title;
    noteText.value = props.text;
    notePriority.value = props.priority;
  }
};

const addToCalender = async () => {
  try {
    await axios({
      method: "POST",
      url: routes.calendar.addNote,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
      data: {
        title: noteTitle.value,
        content: noteText.value,
        priority: notePriority.value,
        date: noteDate.value,
      },
    });
  } catch (error) {
    console.log(error);
  }

  emit("refreshCalendar");
  clearForm();
};

const editNote = async () => {
  try {
    await axios({
      method: "PUT",
      url: routes.calendar.changeNote,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
      data: {
        noteId: props.noteId,
        title: noteTitle.value,
        content: noteText.value,
        priority: notePriority.value,
        date: noteDate.value,
      },
    });
  } catch (error) {
    console.log(error);
  }

  emit("refreshCalendar");
};

const deleteNote = async () => {
  try {
    await axios({
      method: "DELETE",
      url: routes.calendar.deleteNote,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
      data: {
        noteId: props.noteId,
      },
    });
  } catch (error) {
    console.log(error);
  }

  emit("refreshCalendar");
};

const clearForm = () => {
  noteTitle.value = "";
  noteText.value = "";
  notePriority.value = 2;
};

fillValueForEditForm();
</script>

<template>
  <div>
    <form class="row g-3 col-10 mx-auto mt-5">
      <div class="mb-3">
        <div class="form-floating mb-3">
          <input
            type="text"
            class="form-control"
            id="noteTitle"
            placeholder="Podaj tytuł"
            required
            v-model="noteTitle"
          />
          <label for="noteTitle">Tytuł</label>
        </div>
      </div>
      <div class="mb-3">
        <div class="form-floating">
          <textarea
            class="form-control"
            id="noteText"
            placeholder="Podaj treść"
            required
            v-model="noteText"
            style="height: 150px"
          ></textarea>
          <label for="noteText">Treść</label>
        </div>
      </div>
      <div class="mb-3">
        <label>{{ $t("calendar.prioritySelectPlaceholder") }}</label>
        <select
          class="form-select"
          :aria-label="$t('calendar.prioritySelectPlaceholder')"
          v-model="notePriority"
        >
          <option value="1">{{ $t("calendar.priorityLow") }}</option>
          <option value="2">{{ $t("calendar.priorityMedium") }}</option>
          <option value="3">{{ $t("calendar.priorityHigh") }}</option>
        </select>
      </div>
      <div id="submitButton">
        <BasicButton
          v-if="isFormForNewNote"
          :buttonText="$t('calendar.addToCalendarButton')"
          @click.prevent="addToCalender"
        />
        <div v-else class="d-flex gap-3 justify-content-center">
          <BasicButton
            :buttonText="$t('calendar.changeNoteButton')"
            @click.prevent="editNote"
          />
          <BasicButton
            :buttonText="$t('calendar.deleteNoteButton')"
            @click.prevent="deleteNote"
          />
        </div>
      </div>
    </form>
  </div>
</template>

<style scoped lang="scss"></style>
