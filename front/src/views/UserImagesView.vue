<script setup>
import { ref } from "vue";
import axios from "axios";
import routes from "@/helpers/routes";
import { useStore } from "@/stores/store";
import BasicButton from "@/components/BasicButton.vue";

const selectedFile = ref(null);
const imageUrl = ref(null);
const store = useStore();
const userImages = ref([]);
const userImagesList = ref();

const handleFileChange = (event) => {
  const file = event.target.files[0];

  if (file) {
    selectedFile.value = file;
  } else {
    selectedFile.value = null;
  }

  if (selectedFile.value) {
    imageUrl.value = URL.createObjectURL(selectedFile.value);
  }
};

const saveImage = async () => {
  const formData = new FormData();
  formData.append("image", selectedFile.value);

  try {
    await axios({
      method: "POST",
      url: routes.user.image,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
      data: formData,
    });

    selectedFile.value = null;
  } catch (error) {
    console.log(error);
  }
};

const getUserImagesList = async () => {
  let response;

  try {
    response = await axios({
      method: "GET",
      url: routes.user.image,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
    });
  } catch (error) {
    console.log(error);
  }

  userImagesList.value = response.data.response;

  for (const image of userImagesList.value) {
    await getUserImage(image.name);
  }
};

const getUserImage = async (imageName) => {
  let response;

  try {
    response = await axios({
      method: "GET",
      url: `${routes.user.image}/${imageName}`,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
    });

    userImages.value.push(response.data);
  } catch (error) {
    console.log(error);
  }
};

getUserImagesList();
</script>

<template>
  <h1 class="mb-5">Zdjęcia</h1>
  <p>Zapisz ważne dla Ciebie zdjęcia i miej do nich nieograniczony dostęp!</p>
  <div class="user-images mt-10">
    <div>
      <label for="imageToUpload" class="btn btn-primary">Wybierz obraz</label>
      <input id="imageToUpload" type="file" @change="handleFileChange" />
      <img
        v-if="selectedFile"
        :src="imageUrl"
        class="user-images__preview"
        alt="Selected Image"
      />
      <p v-if="!selectedFile" class="alert alert-danger">
        Wybierz plik graficzny
      </p>
      <BasicButton
        buttonText="Zapisz w bazie"
        @click.prevent="saveImage"
        :disabled="!selectedFile"
      />
    </div>
  </div>
  <h3>Twoje zapisane zdjęcia</h3>
  <div v-for="image in userImages" :key="image">
    <div>
      <img :src="image" class="user-images__thumbnail" />
    </div>
  </div>
</template>

<style scoped lang="scss">
.user-images {
  #imageToUpload {
    display: none;
    tab-index: -1;
  }

  &__preview {
    width: 200px;
    object-fit: contain;
  }

  &__thumbnail {
    width: 100px;
    object-fit: contain;
  }
}
</style>
