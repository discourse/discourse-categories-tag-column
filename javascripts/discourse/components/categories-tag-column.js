import Component from "@ember/component";
import { sort } from "@ember/object/computed";
import { tagName } from "@ember-decorators/component";
import { ajax } from "discourse/lib/ajax";

@tagName("")
export default class CategoriesTagColumn extends Component {
  tags = "";
  sortProperties = ["count:desc", "id"];
  isLoading = true;
  moreTags = false;

  @sort("tags", "sortProperties") sortedTags;

  init() {
    super.init(...arguments);

    ajax(`/tags.json`).then((tags) => {
      this.set("tags", tags.tags.slice(0, settings.tag_count));

      if (tags.tags.length > settings.tag_count) {
        this.set("moreTags", true);
      }

      this.set("isLoading", false);
    });
  }
}
