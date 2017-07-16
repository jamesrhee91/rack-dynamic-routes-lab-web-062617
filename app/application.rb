class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/item/)
      item_name = req.path.split("/items/").last
      if handle_search(item_name)
        item = @@items.find {|e| e.name == item_name}
        resp.write item.price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

  def handle_search(item)
    @@items.any? {|e| e.name == item}
  end

end
