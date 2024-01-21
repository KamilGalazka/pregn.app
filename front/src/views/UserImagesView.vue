<script setup>
import { ref } from "vue";
import axios from "axios";
import routes from "@/helpers/routes";
import { useStore } from "@/stores/store";
import BasicButton from "@/components/BasicButton.vue";
import ErrorView from "@/views/ErrorView.vue";

const selectedFile = ref(null);
const imageUrl = ref(null);
const store = useStore();
const userImages = ref([]);
const userImagesList = ref();
const bigImage = ref();

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
    await getUserImagesList();
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

  userImages.value = [];
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

const deleteImage = async (imageIndex) => {
  const imageName = userImagesList.value[imageIndex].name;

  try {
    await axios({
      method: "DELETE",
      url: `${routes.user.image}/${imageName}`,
      headers: {
        Authorization: `Bearer ${store.userToken}`,
      },
    });

    await getUserImagesList();
  } catch (error) {
    console.log(error);
  }
};

const enlargeImage = (imageIndex) => {
  console.log(imageIndex);
  bigImage.value = userImages.value[imageIndex];
};

const reduceImage = () => {
  bigImage.value = "";
};

getUserImagesList();
</script>

<template>
  <div v-if="store.isUserLogged" class="user-images">
    <h1>{{ $t("images.header") }}</h1>
    <p class="text-left mb-15">{{ $t("images.hint") }}</p>

    <div class="container-fluid">
      <div
        class="row d-flex justify-content-center flex-lg-row flex-column align-items-center align-items-xxl-start"
      >
        <div class="col-10 col-xxl-6 mb-5">
          <h3 class="mb-7">{{ $t("images.addNewImageButton") }}</h3>
          <div
            class="user-images__upload-section col-lg-6 d-flex flex-column m-auto mt-10"
          >
            <label for="imageToUpload" class="btn btn-primary">{{
              $t("images.chooseNewImageButton")
            }}</label>
            <input id="imageToUpload" type="file" @change="handleFileChange" />
            <div class="m-auto">
              <img
                v-if="selectedFile"
                :src="imageUrl"
                class="user-images__preview"
                :alt="$t('images.selectedImageAltText')"
              />
              <img
                v-else
                src="../assets/image-placeholder.jpg"
                class="user-images__preview"
                :alt="$t('images.imagePlaceholderAltText')"
              />
            </div>
            <BasicButton
              class="user-images__send-image__button"
              :buttonText="$t('images.addNewImageButton')"
              @click.prevent="saveImage"
              :disabled="!selectedFile"
            />
          </div>
        </div>
        <div class="col-10 col-xxl-6">
          <h3 class="mb-7">
            {{ $t("images.addedImagesSectionHeader") }}
          </h3>
          <p v-if="!userImages.length">
            {{ $t("images.noImagesText") }}
          </p>
          <div
            class="d-flex flex-wrap justify-content-center align-items-center gap-5"
          >
            <div
              v-for="(image, index) in userImages"
              :key="image"
              class="user-images__thumbnail-container"
            >
              <img
                :src="image"
                class="user-images__thumbnail"
                :alt="$t('images.userImageAltText')"
              />
              <div
                class="user-images__thumbnail-actions-container justify-content-center align-items-center"
              >
                <div class="user-images__thumbnail-actions">
                  <font-awesome-icon
                    icon="up-right-and-down-left-from-center"
                    style="color: #000000"
                    size="xl"
                    @click="enlargeImage(index)"
                  />
                  <font-awesome-icon
                    icon="trash"
                    style="color: #000000"
                    size="xl"
                    @click="deleteImage(index)"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-if="bigImage" class="user-images__big-image" @click="reduceImage">
      <img :src="bigImage" :alt="$t('images.enlargedUserImageAltText')" />
    </div>
  </div>
  <ErrorView v-else />
</template>

<style scoped lang="scss">
.user-images {
  #imageToUpload {
    display: none;
    tab-index: -1;
  }

  [for="imageToUpload"] {
    height: 48px;
    line-height: 34px;
  }

  &__send-image__button,
  [for="imageToUpload"] {
    width: 150px;
    margin: 12px auto;
  }

  &__preview {
    width: 250px;
    height: 250px;
    object-fit: cover;
  }

  &__thumbnail {
    width: 200px;
    height: 200px;
    object-fit: cover;
    cursor: pointer;

    &-container {
      position: relative;
      width: 200px;
      height: 250px;

      &:hover {
        opacity: 0.8;

        & .user-images__thumbnail-actions-container {
          top: calc(100% - 50px);
        }
      }
    }

    &-actions-container {
      position: absolute;
      top: calc(100% - 100px);
      left: 0;
      display: flex;
      width: 200px;
      height: 50px;
      z-index: -1;
      transition: top linear 0.2s;

      svg {
        cursor: pointer;
        opacity: 1;

        &:nth-child(1) {
          margin-right: 24px;
        }

        &:hover {
          transform: scale(1.2);
        }
      }
    }
  }

  &__big-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background-color: rgba(221, 221, 221, 0.8);

    img {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
  }
}
</style>
