<script setup>
import { ref } from "vue";
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
      url: routes.calendar.getAllNotes,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
    });

    savedNotes.value = response.data.response;
  } catch (error) {
    console.log(error);
  }
};

const editNote = (note) => {
  console.log("edit", note);
};

getUserCalendar();

// import { useDate } from "vuetify";
// const adapter = useDate();
// import { createVuetify } from "vuetify";
// import DateFnsAdapter from "@date-io/date-fns";
// import en from "../locales/en.json";
// import pl from "../locales/pl.json";
//
// createVuetify({
//   date: {
//     adapter: DateFnsAdapter,
//     locale: {
//       en: en,
//       pl: pl,
//     },
//   },
// });
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
          <div class="accordion" id="notes">
            <div
              v-for="(note, index) in savedNotes"
              :key="note"
              class="accordion-item"
            >
              <div class="accordion-header d-flex" :id="`note${index}`">
                <button
                  class="accordion-button collapsed"
                  type="button"
                  data-bs-toggle="collapse"
                  :data-bs-target="`#note${index}Collapse`"
                  aria-expanded="true"
                  :aria-controls="`note${index}-collapse${index}`"
                >
                  <button
                    @click="editNote(note)"
                    style="width: 50px"
                    data-bs-toggle="modal"
                    data-bs-target="#exampleModal"
                  ></button>
                  <span>
                    <strong>{{ note.date }}</strong> {{ note.title }}
                  </span>
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

<style scoped lang="scss"></style>
