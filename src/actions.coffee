parse = require 'co-body'

module.exports =

  (model) ->

    findAll: ->*
      try
        result = yield model.find(@request.query).exec()
        @body = result
      catch error
        @body = error

    findById: ->*
      try
        result = yield model.findById(@params.id).exec()
        @body = result
      catch error
        @body = error

    deleteById: ->*
      try
        result = yield model.findByIdAndRemove(@params.id).exec()
        @body = result
      catch error
        @body = error

    replaceById: ->*
      try
        yield model.findByIdAndRemove(@params.id).exec()
        body = yield parse @, limit: '1kb'
        newDocument = body
        newDocument._id = @params.id
        result = yield model.create(newDocument)
        @body = result
      catch error
        @body = error

    updateById: ->*
      try
        body = yield parse @, limit: '1kb'
        result = yield model.findByIdAndUpdate(@params.id, body).exec()
        @body = result
      catch error
        @body = error

    create: ->*
      try
        body = yield parse @, limit: '1kb'
        result = yield model.create(body)
        @status = 201
        @body = result
      catch error
        @body = error
