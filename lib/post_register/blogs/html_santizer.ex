defmodule PostRegister.Blogs.HtmlSanitizer do
  def sanitize(text) do
    HtmlSanitizeEx.html5(text)
    |> HtmlSanitizeEx.Parser.parse()
    |> remove_empty_text_nodes()
    |> find_html()
    |> reformat_to_div()
    |> HtmlSanitizeEx.Parser.to_html()
  end

  def remove_empty_text_nodes(text) when is_binary(text) do
    if empty?(text), do: nil, else: text
  end

  def remove_empty_text_nodes(list) when is_list(list) do
    list
    |> Enum.map(&remove_empty_text_nodes/1)
    |> Enum.reject(&is_nil/1)
  end

  def remove_empty_text_nodes({tag_name, attrs, children}) do
    {tag_name, attrs, remove_empty_text_nodes(children)}
  end

  def reformat_to_div({"html", _, children}) do
    {"div", [], reformat_head_and_body_to_div(children)}
  end

  def reformat_to_div({"head", _, children}),
    do: {"div", [], children}

  def reformat_to_div({"body", _, children}),
    do: {"div", [], children}

  def reformat_to_div(any), do: any

  def reformat_head_and_body_to_div(list) when is_list(list) do
    list |> Enum.map(&reformat_to_div/1)
  end

  def find_html([{"html", _, _} = html_node | _]), do: html_node
  def find_html({"html", _, _} = html_node), do: html_node
  def find_html(any), do: any

  @line_break to_string(HtmlSanitizeEx.Parser.replacement_for_linebreak)
  @space to_string(HtmlSanitizeEx.Parser.replacement_for_space)
  @tab to_string(HtmlSanitizeEx.Parser.replacement_for_tab)
  @empty_regex ~r/#{@line_break}+|#{@space}+|#{@tab}+|\t+|\s+|\r+|\n+/

  def empty?(string) do
    String.replace(string, @empty_regex, "") == ""
  end
end
