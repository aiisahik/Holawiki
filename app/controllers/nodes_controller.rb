class NodesController < ApplicationController
  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = Node.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nodes }
    end
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
    @node = Node.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node }
    end
  end


  #load entire tree
  def tree

    @current_node = Node.find(params[:id])

    @scenario = Scenario.find(@current_node.scenario_id)
    @speakers = Speaker.where("scenario_id = ?", @current_node.scenario_id)

    # find all previous nodes
    @tree = []
    @prev_id = @current_node.previous_node_id
    @debug = @current_node.speaker
    while @prev_id > 0
      @node_branch = Node.find(@prev_id)

      @tree.push(@node_branch)
      @prev_id = @node_branch.previous_node_id
    end

    @tree = @tree.reverse
    @next_nodes = Node.where("previous_node_id = ? AND scenario_id = ?", @current_node.id, params[:scenario_id])


    # find the next nodes

    respond_to do |format|
      format.json { render json: {
          :scenario => @scenario,
          :speakers => @speakers,
          :current_node => @current_node,
          :node_tree => @tree,
          :next_nodes => @next_nodes,
          :debug => @debug}}
    end
  end

  def initial

    @scenario = Scenario.find(params[:scenario_id])
    @next_nodes = Node.where("scenario_id = ? AND previous_node_id = 0", params[:scenario_id])
    @speakers = Speaker.where("scenario_id = ?", params[:scenario_id])


    respond_to do |format|
      format.json { render json: {

          :scenario => @scenario,
          :speakers => @speakers,
          :next_nodes => @next_nodes}
      }
    end
  end


  # GET /nodes/new
  # GET /nodes/new.json
  def new
    @node = Node.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @node }
    end
  end

  # GET /nodes/1/edit
  def edit
    @node = Node.find(params[:id])
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = Node.new(params[:node])


    respond_to do |format|
      if @node.save
        format.html { redirect_to @node, notice: 'Node was successfully created.' }
        format.json { render json: @node, status: :created, location: @node }
      else
        format.html { render action: "new" }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nodes/1
  # PUT /nodes/1.json
  def update
    @node = Node.find(params[:id])

    respond_to do |format|
      if @node.update_attributes(params[:node])
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node = Node.find(params[:id])
    @node.destroy

    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.json { head :no_content }
    end
  end
end
