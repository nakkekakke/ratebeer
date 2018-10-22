const BREWERIES = {}

BREWERIES.show = () => {
  $("#brewerytable tr:gt(0)").remove()
  const table = $("#brewerytable")

  BREWERIES.list.forEach((brewery) => {
    table.append('<tr>'
      + '<td>' + brewery['name'] + '</td>'
      + '<td>' + brewery['year'] + '</td>'
      + '<td>' + brewery['beers'] + '</td>'
      + '<td>' + (brewery['active'] == true) + '</td>'
      + '</tr>')
  })
}

BREWERIES.sort_by_name = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase())
  })
}

BREWERIES.sort_by_year = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year < b.year
  })
}

BREWERIES.sort_by_beers = () => {
  BREWERIES.list.sort((a, b) => {
    return a.beers < b.beers
  })
}

BREWERIES.sort_by_active = () => {
  BREWERIES.list.sort((a, b) => {
    return a.active < b.active
  })
}

document.addEventListener("turbolinks:load", () => {
  if ($("#brewerytable").length == 0) {
    return
  }

  $.getJSON('breweries.json', (breweries) => {
    BREWERIES.list = breweries
    BREWERIES.sort_by_name()
    BREWERIES.show()
  })

  $("#name").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_name()
    BREWERIES.show()
  })

  $("#year").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_year()
    BREWERIES.show()
  })

  $("#beers").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_beers()
    BREWERIES.show()
  })

  $("#active").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_active()
    BREWERIES.show()
  })
})