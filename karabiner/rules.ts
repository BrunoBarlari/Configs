import fs from "fs";
import { KarabinerRules } from "./types";
import { app, createHyperSubLayers, open, shell, window } from "./utils";

const rules: KarabinerRules[] = [
  // Define the Hyper key itself
  {
    description: "Hyper Key (⌃⌥⇧⌘)",
    
    manipulators: [
      {
        description: "Caps Lock -> Hyper Key",
        from: {
          key_code: "caps_lock",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            set_variable: {
              name: "hyper",
              value: 1,
            },
          },
          {
            "key_code": "left_control",
            "modifiers": ["right_command", "left_option"]
          },

        ],
        to_after_key_up: [
          {
            set_variable: {
              name: "hyper",
              value: 0,
            },
          },
        ],
        to_if_alone: [
          {
            key_code: "escape",
          },
        ],
        type: "basic",
      }
    ],
  },
  ...createHyperSubLayers({
    
    // b = "B"rowse
    s:{
      k: open("https://twitter.com"),
      // Quarterly "P"lan
      t: open("https://www.youtube.com"),
      o: open("https://reddit.com"),
      r: open("https://perplexity.ai"),
    },



    // o = "Open" applications
    spacebar: {
      1: app("1Password"),
      j: app("Safari"),
      h: app("Discord"),
      k: app("Warp"), //Warp
      y: app("Finder"),
      // "i"Message
      i: app("Visual Studio Code"),
      // "W"hatsApp has been replaced by Texts
      m: open("WhatsApp"),
    },
  }),  
] 

  fs.writeFileSync(
  "karabiner.json",
  JSON.stringify(
    {
      global: {
        show_in_menu_bar: false,
      },
      profiles: [
        {
          name: "Default",
          complex_modifications: {
            rules,
          },
        },
      ],
    },
    null,
    2
  )
);
