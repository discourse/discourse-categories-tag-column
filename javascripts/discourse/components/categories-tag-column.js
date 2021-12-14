import { ajax } from "discourse/lib/ajax";
import Component from "@ember/component";
import { sort } from "@ember/object/computed";

export default Component.extend({
  tagName: "",
  tags: "",
  sortProperties: ["count:desc", "id"],
  sortedTags: sort("tags", "sortProperties"),
  isLoading: true,
  moreTags: false,

  init() {
    this._super(...arguments);

    ajax(`/tags.json`).then((tags) => {
      this.set("tags", tags.tags.slice(0, settings.tag_count));

      if (tags.tags.length > settings.tag_count) {
        this.set("moreTags", true);
      }

      this.set("isLoading", false);
    });
  },
});
