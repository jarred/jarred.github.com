jb = window.JB ||= {}
jb.Templates =

  favicon: _.template """
    <div class="border top"></div>
    <div class="border left"></div>
    <!--
    <div class="favicon">
      <img src="<%= favicon %>" />
      <div class="gloss"></div>
    </div>
    -->
  """