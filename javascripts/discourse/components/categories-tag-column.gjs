import Component from "@ember/component";
import { sort } from "@ember/object/computed";
import { tagName } from "@ember-decorators/component";
import ConditionalLoadingSpinner from "discourse/components/conditional-loading-spinner";
import discourseTag from "discourse/helpers/discourse-tag";
import { ajax } from "discourse/lib/ajax";
import { i18n } from "discourse-i18n";

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

  <template>
    <ConditionalLoadingSpinner @condition={{this.isLoading}}>
      {{#if this.sortedTags}}
        <div class="table-heading">
          Tags
        </div>

        <ul class="categories-tag-list">
          {{#each this.sortedTags as |t|}}
            <li>{{discourseTag t.name count=t.count}}</li>
          {{/each}}
        </ul>

        {{#if this.moreTags}}
          <div class="more-tags">
            <a href="/tags" class="btn btn-default">{{i18n "more"}}</a>
          </div>
        {{/if}}
      {{/if}}
    </ConditionalLoadingSpinner>
  </template>
}
