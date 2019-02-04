var JSNES = jsnes || require('jsnes')


;(function() {
  var root = this

  const EmbedJSNES = function(options) {
    options = options || {}

    const SCREEN_WIDTH = options.width || 256;
    const SCREEN_HEIGHT = options.height || 240;
    const FRAMEBUFFER_SIZE = SCREEN_WIDTH*SCREEN_HEIGHT;


    var canvas_ctx, image;
    var framebuffer_u8, framebuffer_u32;

    var AUDIO_BUFFERING = 512;
    var SAMPLE_COUNT = 4*1024;
    var SAMPLE_MASK = SAMPLE_COUNT - 1;
    var audio_samples_L = new Float32Array(SAMPLE_COUNT);
    var audio_samples_R = new Float32Array(SAMPLE_COUNT);
    var audio_write_cursor = 0, audio_read_cursor = 0;

    var interface = {}

    interface.NES = new JSNES.NES({
      onFrame: function(framebuffer_24){
        for(var i = 0; i < FRAMEBUFFER_SIZE; i++) framebuffer_u32[i] = 0xFF000000 | framebuffer_24[i];
      },
      onAudioSample: function(l, r){
        audio_samples_L[audio_write_cursor] = l;
        audio_samples_R[audio_write_cursor] = r;
        audio_write_cursor = (audio_write_cursor + 1) & SAMPLE_MASK;
      },
    });

    interface.onAnimationFrame = function onAnimationFrame(){
      window.requestAnimationFrame(interface.onAnimationFrame);

      image.data.set(framebuffer_u8);
      canvas_ctx.putImageData(image, 0, 0);
      interface.NES.frame();
    }

    interface.audio_remain = function audio_remain(){
      return (audio_write_cursor - audio_read_cursor) & SAMPLE_MASK;
    }

    interface.audio_callback = function audio_callback(event){
      var dst = event.outputBuffer;
      var len = dst.length;

      // Attempt to avoid buffer underruns.
      if(interface.audio_remain() < AUDIO_BUFFERING) interface.NES.frame();

      var dst_l = dst.getChannelData(0);
      var dst_r = dst.getChannelData(1);
      for(var i = 0; i < len; i++){
        var src_idx = (audio_read_cursor + i) & SAMPLE_MASK;
        dst_l[i] = audio_samples_L[src_idx];
        dst_r[i] = audio_samples_R[src_idx];
      }

      audio_read_cursor = (audio_read_cursor + len) & SAMPLE_MASK;
    }

    interface.keyboard = function keyboard(callback, event){
      var player = 1;
      switch(event.keyCode){
        case 87: // W
          callback(player, jsnes.Controller.BUTTON_UP); break;
        case 83: // D
          callback(player, jsnes.Controller.BUTTON_DOWN); break;
        case 65: // A
          callback(player, jsnes.Controller.BUTTON_LEFT); break;
        case 68: // S
          callback(player, jsnes.Controller.BUTTON_RIGHT); break;
        case 75: // L
          callback(player, jsnes.Controller.BUTTON_A); break;
        case 83: //K
          callback(player, jsnes.Controller.BUTTON_B); break;
        case 16: // shift
          callback(player, jsnes.Controller.BUTTON_SELECT); break;
        case 13: // Return
          callback(player, jsnes.Controller.BUTTON_START); break;
        default: break;
      }
    }

    interface.nes_init = function nes_init(canvas_id){
      var canvas = document.getElementById(canvas_id);
      canvas_ctx = canvas.getContext("2d");
      image = canvas_ctx.getImageData(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

      canvas_ctx.fillStyle = "black";
      canvas_ctx.fillRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

      // Allocate framebuffer array.
      var buffer = new ArrayBuffer(image.data.length);
      framebuffer_u8 = new Uint8ClampedArray(buffer);
      framebuffer_u32 = new Uint32Array(buffer);

      // Setup audio.
      var ctx_proto = window.AudioContext || window.webkitAudioContext;
      var audio_ctx = new ctx_proto();

      // var fix_audio = function(e){
      //  if(window.audioContext){
      //    // Create empty buffer
      //    var buffer = window.audioContext.createBuffer(1, 1, 22050);
      //    var source = window.audioContext.createBufferSource();
      //    source.buffer = buffer;
      //    // Connect to output (speakers)
      //    source.connect(window.audioContext.destination);
      //    // Play sound
      //    if (source.start) {
      //      source.start(0);
      //    } else if (source.play) {
      //      source.play(0);
      //    } else if (source.noteOn) {
      //      source.noteOn(0);
      //    }
      //  }
      //  document.removeEventListener('touchend', fix_audio);
      // };
      // document.addEventListener('touchend', fix_audio);

      var script_processor = audio_ctx.createScriptProcessor(AUDIO_BUFFERING, 0, 2);
      script_processor.onaudioprocess = interface.audio_callback;
      script_processor.connect(audio_ctx.destination);
    }

    interface.nes_boot = function nes_boot(rom_data){
      interface.NES.loadROM(rom_data);
      window.requestAnimationFrame(interface.onAnimationFrame);
    }

    interface.nes_load_data = function nes_load_data(canvas_id, rom_data){
      interface.nes_init(canvas_id);
      interface.nes_boot(rom_data);
    }

    interface.nes_load_url = function nes_load_url(canvas_id, path){
      interface.nes_init(canvas_id);

      var req = new XMLHttpRequest();
      req.open("GET", path);
      req.overrideMimeType("text/plain; charset=x-user-defined");
      req.onerror = () => console.log(`Error loading ${path}: ${req.statusText}`);

      req.onload = function() {
        if (this.status === 200) {
        interface.nes_boot(this.responseText);
        } else if (this.status === 0) {
          // Aborted, so ignore error
        } else {
          req.onerror();
        }
      };

      req.send();
    }

    document.addEventListener('keydown', (event) => {interface.keyboard(interface.NES.buttonDown, event)});
    document.addEventListener('keyup', (event) => {interface.keyboard(interface.NES.buttonUp, event)});



    return interface
  }

  if (typeof exports !== 'undefined') {
    if (typeof module !== 'undefined' && module.exports) {
      exports = module.exports = EmbedJSNES;
    }
    exports.EmbedJSNES = EmbedJSNES;
  } else {
    root.EmbedJSNES = EmbedJSNES;
  }
}).call(this)