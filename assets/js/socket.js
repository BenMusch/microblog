import {Socket} from "phoenix"
import {EventBus} from "./event-bus"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("updates:all", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("message", (msg) => EventBus.$emit("message:add", msg))

export default socket
