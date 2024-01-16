<script setup>
import { onMounted, ref } from "vue";
import axios from "axios";
import CalendarForm from "@/components/calendar/CalendarForm.vue";
import { useStore } from "@/stores/store";
import routes from "@/helpers/routes";
import ErrorView from "@/views/ErrorView.vue";

const store = useStore();
const date = ref(new Date());
const savedNotes = ref([]);

const getUserCalendar = async () => {
  let response;

  try {
    response = await axios({
      method: "GET",
      url: routes.calendar,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
    });

    savedNotes.value = response.data.response;

    sortNotesByDate();
    sortNotesByPriority();
  } catch (error) {
    console.log(error);
  }
};

const sortNotesByPriority = () => {
  savedNotes.value.sort((a, b) => b.priority - a.priority);
};

const sortNotesByDate = () => {
  savedNotes.value.sort((a, b) => {
    const firstDateParts = a.date.split("/");
    const secondDateParts = b.date.split("/");
    const newFirstDate = new Date(
      firstDateParts[2],
      firstDateParts[1] - 1,
      firstDateParts[0]
    );
    const newSecondDate = new Date(
      secondDateParts[2],
      secondDateParts[1] - 1,
      secondDateParts[0]
    );

    return newFirstDate - newSecondDate;
  });
};

const setNoteHeaderClassName = (notePriority) => {
  const basicClassName = "accordion-button collapsed";
  const priorityClassNames = ["low", "medium", "high"];

  return `${basicClassName} priority-${priorityClassNames[notePriority - 1]}`;
};

const displayNoteDate = (date) => {
  const dateParts = date.split("/");
  const day = dateParts[0] < 9 ? `0${dateParts[0]}` : dateParts[0];
  const month = dateParts[1] < 9 ? `0${dateParts[1]}` : dateParts[1];
  const year = dateParts[2];

  return `${day}/${month}/${year}`;
};

onMounted(() => {
  getUserCalendar();
});
</script>

<template>
  <div v-if="store.isUserLogged">
    <h1>{{ $t("calendar.header") }}</h1>
    <p class="text-left mb-15">{{ $t("calendar.hint") }}</p>

    <div class="container-fluid">
      <div
        class="row d-flex justify-content-center flex-lg-row flex-column align-items-center align-items-xxl-start"
      >
        <div class="col-10 col-xxl-6 mb-5">
          <h3 class="mb-7">{{ $t("calendar.addToCalendarSectionHeader") }}</h3>
          <v-container required>
            <v-row justify="space-around">
              <v-date-picker
                show-adjacent-months
                elevation="5"
                width="400"
                color="primary"
                :hide-header="true"
                v-model="date"
              ></v-date-picker>
            </v-row>
          </v-container>

          <CalendarForm
            :date="date"
            form-type="create"
            @refresh-calendar="getUserCalendar"
          />
        </div>
        <div class="col-10 col-xxl-6">
          <h3 class="mb-7">
            {{ $t("calendar.addedNotesSectionHeader") }}
          </h3>
          <p v-if="!savedNotes.length">
            {{ $t("calendar.emptyCalendarText") }}
          </p>
          <div class="accordion" id="notes">
            <div
              v-for="(note, index) in savedNotes"
              :key="note"
              class="accordion-item"
            >
              <div class="accordion-header d-flex" :id="`note${index}`">
                <button
                  :class="setNoteHeaderClassName(note.priority)"
                  type="button"
                  data-bs-toggle="collapse"
                  :data-bs-target="`#note${index}Collapse`"
                  aria-expanded="true"
                  :aria-controls="`note${index}-collapse${index}`"
                >
                  <span class="accordion-header__date"
                    >{{ $t("calendar.noteDate") }}
                    {{ displayNoteDate(note.date) }}</span
                  >
                  <span class="accordion-header__title"
                    >{{ $t("calendar.noteTitle") }} {{ note.title }}</span
                  >
                </button>
              </div>
              <div
                :id="`note${index}Collapse`"
                class="accordion-collapse collapse"
                :aria-labelledby="`note${index}-collapse${index}`"
              >
                <div class="accordion-body">
                  <CalendarForm
                    :date="date"
                    form-type="edit"
                    :converted-date="note.date"
                    :title="note.title"
                    :text="note.content"
                    :priority="note.priority"
                    :note-id="note.id"
                    @refresh-calendar="getUserCalendar"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <ErrorView v-else />
</template>

<style scoped lang="scss">
.accordion {
  &-header__date {
    min-width: 150px;
  }

  &-button:not(.collapsed),
  &-button:not(.collapsed) span {
    color: black;
  }
}

.priority {
  box-shadow: none;

  &-high {
    background: #f1aeb5;
  }

  &-medium {
    background: #f7caa0;
  }

  &-low {
    background: #a3cfbb;
  }
}

#notes {
  .accordion-item {
    margin-bottom: 12px;
  }
}
</style>
