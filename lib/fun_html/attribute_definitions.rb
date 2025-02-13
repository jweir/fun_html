# frozen_string_literal: true

module FunHtml
  # HTML attributes autogenerated, do not edit
  module AttributeDefinitions
    # Specifies file types browser will accept
    def accept(value) = write(' accept="', value)
    # Character encodings used for form submission
    def accept_charset(value) = write(' accept-charset="', value)
    # Keyboard shortcut to access element
    def accesskey(value) = write(' accesskey="', value)
    # URL where form data is submitted
    def action(value) = write(' action="', value)
    # Alignment of content
    def align(value) = write(' align="', value)
    # Alternative text for images
    def alt(value) = write(' alt="', value)
    # Script should execute asynchronously
    def async(value) = write_empty(' async', value)
    # Form/input autocompletion
    def autocomplete(value) = write(' autocomplete="', value)
    # Element should be focused on page load
    def autofocus(value) = write_empty(' autofocus', value)
    # Media will start playing automatically
    def autoplay(value) = write_empty(' autoplay', value)
    # Background color of element
    def bgcolor(value) = write(' bgcolor="', value)
    # Border width in pixels
    def border(value) = write(' border="', value)
    # Character encoding of document
    def charset(value) = write(' charset="', value)
    # Whether checkbox/radio button is selected
    def checked(value) = write_empty(' checked', value)
    # CSS class name(s) for styling
    def klass(value) = write(' class="', value)
    # Number of columns in textarea
    def cols(value) = write(' cols="', value)
    # Number of columns a cell spans
    def colspan(value) = write(' colspan="', value)
    # Content for meta tags
    def content(value) = write(' content="', value)
    # Whether content is editable
    def contenteditable(value) = write(' contenteditable="', value)
    # Show media playback controls
    def controls(value) = write_empty(' controls', value)
    # Coordinates for image maps
    def coords(value) = write(' coords="', value)

    # Custom data attributes
    def data(suffix, value)
      unless suffix.match?(/\A[a-z-]+\z/)
        raise ArgumentError,
              "suffix (#{suffix}) must be lowercase and only contain 'a' to 'z' or hyphens."
      end

      write(" data-#{suffix}=\"", value)
    end

    # Date/time of element content
    def datetime(value) = write(' datetime="', value)
    # Default track for media
    def default(value) = write_empty(' default', value)
    # Script should execute after parsing
    def defer(value) = write_empty(' defer', value)
    # Text direction
    def dir(value) = write(' dir="', value)
    # Element is disabled
    def disabled(value) = write_empty(' disabled', value)
    # Resource should be downloaded
    def download(value) = write(' download="', value)
    # Element can be dragged
    def draggable(value) = write(' draggable="', value)
    # Form data encoding for submission
    def enctype(value) = write(' enctype="', value)
    # Associates label with form control
    def for(value) = write(' for="', value)
    # Form the element belongs to
    def form(value) = write(' form="', value)
    # URL for form submission
    def formaction(value) = write(' formaction="', value)
    # Related header cells for data cell
    def headers(value) = write(' headers="', value)
    # Height of element
    def height(value) = write(' height="', value)
    # Element is not displayed
    def hidden(value) = write_empty(' hidden', value)
    # Upper range of meter
    def high(value) = write(' high="', value)
    # URL of linked resource
    def href(value) = write(' href="', value)
    # Language of linked resource
    def hreflang(value) = write(' hreflang="', value)
    # Unique identifier for element
    def id(value) = write(' id="', value)
    # Subresource integrity hash
    def integrity(value) = write(' integrity="', value)
    # Image is server-side image map
    def ismap(value) = write_empty(' ismap', value)
    # Type of text track
    def kind(value) = write(' kind="', value)
    # Label for form control/option
    def label(value) = write(' label="', value)
    # Language of element content
    def lang(value) = write(' lang="', value)
    # Links input to datalist options
    def list(value) = write(' list="', value)
    # Media will replay when finished
    def loop(value) = write_empty(' loop', value)
    # Lower range of meter
    def low(value) = write(' low="', value)
    # Maximum allowed value
    def max(value) = write(' max="', value)
    # Maximum length of input
    def maxlength(value) = write(' maxlength="', value)
    # Media type for resource
    def media(value) = write(' media="', value)
    # HTTP method for form submission
    def method(value) = write(' method="', value)
    # Minimum allowed value
    def min(value) = write(' min="', value)
    # Multiple values can be selected
    def multiple(value) = write_empty(' multiple', value)
    # Media is muted by default
    def muted(value) = write_empty(' muted', value)
    # Name of form control
    def name(value) = write(' name="', value)
    # Form validation is skipped
    def novalidate(value) = write_empty(' novalidate', value)
    # Details element is expanded
    def open(value) = write_empty(' open', value)
    # Optimal value for meter
    def optimum(value) = write(' optimum="', value)
    # Regular expression pattern
    def pattern(value) = write(' pattern="', value)
    # Hint text for input field
    def placeholder(value) = write(' placeholder="', value)
    # Preview image for video
    def poster(value) = write(' poster="', value)
    # How media should be loaded
    def preload(value) = write(' preload="', value)
    # Input field cannot be modified
    def readonly(value) = write_empty(' readonly', value)
    # Relationship of linked resource
    def rel(value) = write(' rel="', value)
    # Input must be filled out
    def required(value) = write_empty(' required', value)
    # List is numbered in reverse
    def reversed(value) = write_empty(' reversed', value)
    # Number of rows in textarea
    def rows(value) = write(' rows="', value)
    # Number of rows a cell spans
    def rowspan(value) = write(' rowspan="', value)
    # Security rules for iframe
    def sandbox(value) = write(' sandbox="', value)
    # Specifies the number of consecutive columns the <colgroup> element spans. The value must be a positive integer greater than zero. If not present, its default value is 1.
    def span(value) = write(' span="', value)
    # Cells header element relates to
    def scope(value) = write(' scope="', value)
    # Option is pre-selected
    def selected(value) = write_empty(' selected', value)
    # Shape of image map area
    def shape(value) = write(' shape="', value)
    # Size of input/select control
    def size(value) = write(' size="', value)
    # Image sizes for different layouts
    def sizes(value) = write(' sizes="', value)
    # Element should be spellchecked
    def spellcheck(value) = write(' spellcheck="', value)
    # URL of resource
    def src(value) = write(' src="', value)
    # Content for inline frame
    def srcdoc(value) = write(' srcdoc="', value)
    # Language of text track
    def srclang(value) = write(' srclang="', value)
    # Images to use in different situations
    def srcset(value) = write(' srcset="', value)
    # Starting number for ordered list
    def start(value) = write(' start="', value)
    # Increment for numeric input
    def step(value) = write(' step="', value)
    # Inline CSS styles
    def style(value) = write(' style="', value)
    # Position in tab order
    def tabindex(value) = write(' tabindex="', value)
    # Where to open linked document
    def target(value) = write(' target="', value)
    # Advisory information about element
    def title(value) = write(' title="', value)
    # Whether to translate content
    def translate(value) = write(' translate="', value)
    # Type of element or input
    def type(value) = write(' type="', value)
    # Image map to use
    def usemap(value) = write(' usemap="', value)
    # Value of form control
    def value(value) = write(' value="', value)
    # Width of element
    def width(value) = write(' width="', value)
    # How text wraps in textarea
    def wrap(value) = write(' wrap="', value)
    def onabort(value) = write(' onabort="', value)
    def onauxclick(value) = write(' onauxclick="', value)
    def onbeforeinput(value) = write(' onbeforeinput="', value)
    def onbeforematch(value) = write(' onbeforematch="', value)
    def onbeforetoggle(value) = write(' onbeforetoggle="', value)
    def oncancel(value) = write(' oncancel="', value)
    def oncanplay(value) = write(' oncanplay="', value)
    def oncanplaythrough(value) = write(' oncanplaythrough="', value)
    def onchange(value) = write(' onchange="', value)
    def onclick(value) = write(' onclick="', value)
    def onclose(value) = write(' onclose="', value)
    def oncontextlost(value) = write(' oncontextlost="', value)
    def oncontextmenu(value) = write(' oncontextmenu="', value)
    def oncontextrestored(value) = write(' oncontextrestored="', value)
    def oncopy(value) = write(' oncopy="', value)
    def oncuechange(value) = write(' oncuechange="', value)
    def oncut(value) = write(' oncut="', value)
    def ondblclick(value) = write(' ondblclick="', value)
    def ondrag(value) = write(' ondrag="', value)
    def ondragend(value) = write(' ondragend="', value)
    def ondragenter(value) = write(' ondragenter="', value)
    def ondragleave(value) = write(' ondragleave="', value)
    def ondragover(value) = write(' ondragover="', value)
    def ondragstart(value) = write(' ondragstart="', value)
    def ondrop(value) = write(' ondrop="', value)
    def ondurationchange(value) = write(' ondurationchange="', value)
    def onemptied(value) = write(' onemptied="', value)
    def onended(value) = write(' onended="', value)
    def onformdata(value) = write(' onformdata="', value)
    def oninput(value) = write(' oninput="', value)
    def oninvalid(value) = write(' oninvalid="', value)
    def onkeydown(value) = write(' onkeydown="', value)
    def onkeypress(value) = write(' onkeypress="', value)
    def onkeyup(value) = write(' onkeyup="', value)
    def onloadeddata(value) = write(' onloadeddata="', value)
    def onloadedmetadata(value) = write(' onloadedmetadata="', value)
    def onloadstart(value) = write(' onloadstart="', value)
    def onmousedown(value) = write(' onmousedown="', value)
    def onmouseenter(value) = write(' onmouseenter="', value)
    def onmouseleave(value) = write(' onmouseleave="', value)
    def onmousemove(value) = write(' onmousemove="', value)
    def onmouseout(value) = write(' onmouseout="', value)
    def onmouseover(value) = write(' onmouseover="', value)
    def onmouseup(value) = write(' onmouseup="', value)
    def onpaste(value) = write(' onpaste="', value)
    def onpause(value) = write(' onpause="', value)
    def onplay(value) = write(' onplay="', value)
    def onplaying(value) = write(' onplaying="', value)
    def onprogress(value) = write(' onprogress="', value)
    def onratechange(value) = write(' onratechange="', value)
    def onreset(value) = write(' onreset="', value)
    def onscrollend(value) = write(' onscrollend="', value)
    def onsecuritypolicyviolation(value) = write(' onsecuritypolicyviolation="', value)
    def onseeked(value) = write(' onseeked="', value)
    def onseeking(value) = write(' onseeking="', value)
    def onselect(value) = write(' onselect="', value)
    def onslotchange(value) = write(' onslotchange="', value)
    def onstalled(value) = write(' onstalled="', value)
    def onsubmit(value) = write(' onsubmit="', value)
    def onsuspend(value) = write(' onsuspend="', value)
    def ontimeupdate(value) = write(' ontimeupdate="', value)
    def ontoggle(value) = write(' ontoggle="', value)
    def onvolumechange(value) = write(' onvolumechange="', value)
    def onwaiting(value) = write(' onwaiting="', value)
    def onwheel(value) = write(' onwheel="', value)
  end
end
