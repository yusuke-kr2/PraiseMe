document.addEventListener("turbo:load", () => {
  const btn = document.getElementById("recordToggleButton");
  const icon = document.getElementById("recordIcon");
  const label = document.getElementById("recordLabel");
  const audioInput = document.getElementById("audioInput");
  const form = document.getElementById("praiseForm");

  if (!btn) return; // ページにボタンが無いとき何もしない

  let mediaRecorder;
  let audioChunks = [];
  let isRecording = false;

  btn.addEventListener("click", async () => {
    if (!isRecording) {
      // ========== 録音開始 ==========
      const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
      mediaRecorder = new MediaRecorder(stream);
      mediaRecorder.start();

      audioChunks = [];
      mediaRecorder.ondataavailable = e => audioChunks.push(e.data);

      // 見た目更新
      btn.classList.add("recording");
      label.textContent = "録音停止";

      isRecording = true;

    } else {
      // ========== 録音停止 ==========
      mediaRecorder.stop();

      mediaRecorder.onstop = () => {
        const audioBlob = new Blob(audioChunks, { type: "audio/wav" });
        const file = new File([audioBlob], "praise.wav", { type: "audio/wav" });

        const dt = new DataTransfer();
        dt.items.add(file);
        audioInput.files = dt.files;

        form.submit();
      };

      // ボタンを元に戻す
      btn.classList.remove("recording");
      label.textContent = "録音開始";

      isRecording = false;
    }
  });
});
