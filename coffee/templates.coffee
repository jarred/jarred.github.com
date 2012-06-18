jb = window.JB ||= {}
jb.Templates =

  favicon: _.template """
    <div class="connection"></div>
    <div class="favicon">
      <img src="<%= favicon %>" />
    </div>
  """