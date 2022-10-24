class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # 1. Pegar todas as receitas do cookbook
    recipes = @cookbook.all

    # 2. Mandar a view mostrar as recipes para o usuário
    @view.display_list(recipes)
  end

  def create
    # 1. Perguntar o nome da receita
    name = @view.ask_name

    # 2. Perguntar a descrição da receita
    description = @view.ask_description

    # 3. Perguntar o rating da receita
    rating = @view.ask_rating

    # 4. Perguntar o tempo de preparo da receita
    prep_time = @view.ask_prep_time

    # 4. Criar um novo objeto recipe
    new_recipe = Recipe.new(name, description, rating, prep_time)

    # 5. Adicionar o novo objeto recipe ao cookbook
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # 1. Mostrar todas as receitas
    list

    # 2. Perguntar qual o index da receita a ser removida
    index = @view.ask_index

    # 3. Manda o cookbook remover a receita pelo index
    @cookbook.remove_recipe(index)
  end

  def mark_as_done
    # 1. Mostrar todas as receitas
    list

    # 2. Pergutar qual o index da receita a ser marcada como feita
    index = @view.ask_index


    # 3. Mandar o cookbook marcar como feita pelo index
    @cookbook.mark_as_done(index)
  end

  def import
    # Perguntar o ingrediente
    ingredient = @view.ask_ingredient

    # Montamos a URL de busca
    url = "https://www.tudoreceitas.com/pesquisa?q=#{ingredient}"

    # Pegamos o HTML da página
    doc = Nokogiri::HTML(URI.open(url).read, nil, "utf-8")


    # Encontramos todos 5 primeiros links de receitas
    tags = doc.search('a.titulo.titulo--resultado').first(5)

    # array das páginas das receitas
    links = []


    # Para cada link de receita
    tags.each_with_index do |tag, index|
      puts "#{index + 1} - #{tag.text}"
      links << tag.attributes['href'].value
    end

    # Perguntar qual o index da receita ele quer importar
    index = @view.ask_index

    # URL da página da receita selecionada
    url = links[index]

    # Pegamos o HTML da página
    doc = Nokogiri::HTML(URI.open(url).read, nil, "utf-8")

    # scrape do nome
    name = doc.search('h1').text.gsub(/^Receita de /, '')

    # scrape da descrição
    description = doc.search('.apartado').text.strip.gsub(/\n/, '')

    # Se existir nota
    if doc.search('.votos').text.strip.match(/Avaliação: (\d,\d)/)
      # scrape do rating
      rating = doc.search('.votos').text.strip.match(/Avaliação: (\d,\d)/)[1].gsub(',','.').to_f.round(0)
    end

    # Scrape do preptime
    prep_time = doc.search('.property.duracion').text

    # Criamos a instância de recipe
    new_recipe = Recipe.new(name, description, rating, prep_time)

    # Adicionamos a recipe ao cookbook
    @cookbook.add_recipe(new_recipe)



  end

end
