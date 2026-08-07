# ripple-ark

Ripple-native bindings for the current [Zag JS component machines](https://zagjs.com/components/overview).

The package owns machine startup, Ripple reactivity, and prop normalization. Applications own markup,
content, styling, collections, and icons.

```ts
import { useAccordion } from "@celados/ripple-ark";

const api = useAccordion({ id: "settings" });
```

`api` is a Ripple `Tracked` value. Read the connected Zag API from `api.value` inside TSRX markup.

The package intentionally does not re-export Zag machines or generic Zag helpers. That keeps the
adapter boundary small and prevents consumers from depending on implementation details.
