<template>
  <div class="message-list">
    <div v-for="message in messages" class="row message item" :id="'message-' + message.id">
      <div class="col-md-1">
        <div class="avatar-container-sm panel">
          <img :src="message.avatarUrl" alt="avatar"/>
        </div>
      </div>

      <div class="col-md-11 content">
        <p>{{ message.content }}</p>

        <like-btn
           :user-id="currentUserId"
           :message-id="message.id"
           :liked="message.likedByCurrentUser"
           :count="message.numLikes"
           target-url="/api/likes"
        />

        <span class="metadata">
          <strong>
            <a :href="message.user.path" class="text-dark">{{ message.user.name }}</a>
          </strong>
          <a :href="message.user.path" class="text-secondary">@{{ message.user.handle }}</a>

          <small>
            <a :href="message.path">{{ message.createdAt }}</a>
            <a data-confirm="Are you sure?" data-csrf="csrfToken"
              data-method="delete" :data-to="message.path" href="#"
              rel="nofollow" class="text-danger"
              v-if="message.userId == currentUserId">Delete</a>
          </small>
        </span>
      </div>
    </div>
  </div>
</template>

<script>
import Like from "./like.vue"
export default {
  name: 'message-list',
  props: ['initialData', 'currentUserId', 'csrfToken'],
  components: {
    'like-btn': Like
  },
  data() {
    return {
      messages: this.initialData
    }
  }
}
</script>
