<template>
  <div class="like-btn">
    <button class="btn text-light btn-primary"
      @click="handleClick"
      :disabled="!isLoggedIn">{{ btnText }}</button>
  </div>
</template>

<script>
export default {
  name: 'like-btn',
  props: ['targetUrl', 'userId', 'messageId', 'count', 'liked'],
  data() {
    return {
      userLikes: this.liked || false,
      numLikes: this.count || 0
    }
  },

  computed: {
    btnText() {
      const msg = this.userLikes ? 'Unlike' : 'Like';
      return `${msg} (${this.numLikes})`;
    },

    isLoggedIn() {
      return !!this.userId;
    }
  },

  methods: {
    handleClick() {
      if (this.userLikes)
        this.unlike();
      else
        this.like();
    },

    like() {
      if (!this.isLoggedIn || this.userLikes) return;
      this.userLikes = true;
      this.numLikes += 1;

      this.sendRequest('POST');
    },

    unlike() {
      if (!this.isLoggedIn || !this.userLikes) return;
      this.userLikes = false;
      this.numLikes -= 1;

      this.sendRequest('DELETE');
    },

    sendRequest(method) {
      console.log(this.messageId)
      console.log(this.userId)
      $.ajax({
        url: this.targetUrl,
        contentType: 'application/json',
        dataType: 'json',
        method: method,
        data: JSON.stringify({
          like: {
            message_id: this.messageId,
            user_id: this.userId
          }
        })
      });
    }
  }
}
</script>
