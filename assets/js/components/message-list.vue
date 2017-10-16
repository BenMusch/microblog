<template>
  <div class="message-list">
    <div v-for="message in messages" class="row message item" :id="'message-' + message.id">
      <div class="col-md-1">
        <div class="avatar-container-sm panel">
          <img :src="avatarUrl" alt="avatar"/>
        </div>
      </div>

      <div class="col-md-11 content">
        <p>{{ message.content }}</p>

        <like-btn
           :user-id="userId"
           :message-id="message.id"
           :liked="message.likedByCurrentUser"
           :count="message.numLikes"
           target-url="/api/likes"
          />
      </div>
    </div>
  </div>
</template>
