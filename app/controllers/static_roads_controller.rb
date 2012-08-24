class StaticRoadsController < ApplicationController
  def index
    @roads = StaticRoad.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @roads }
    end
  end

  def new
    @road = StaticRoad.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @road }
    end
  end

  def show
    @road = StaticRoad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @road }
    end
  end

  # POST /road
  # POST /road.json
  def create
    @road = StaticRoad.new(params[:static_road])
    xxRoad = StaticRoad.find_or_create_by(:name=>@road.name)
    @road.static_pois.each do |poi|
	xxRoad.static_pois.find_or_create_by(:ref => poi.ref, :ref_type => poi.ref_type)
    end
    respond_to do |format|
        format.html { redirect_to xxRoad, notice: 'road was successfully created.' }
        format.json { render json: xxRoad}
    end
    		
#    respond_to do |format|
#      if @road.save
#        format.html { redirect_to @road, notice: 'road was successfully created.' }
#        format.json { render json: {:result=>"succeeded!"}, status: :created, location: @road }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @road.errors, status: :unprocessable_entity }
#      end
#    end
  end

  def fix
    #@static_roads = StaticRoad.all.limit(20)
    @static_roads = StaticRoad.all.paginate :page => params[:page], :per_page => 11
    @static_pois = [] #@static_roads.first.static_pois
    
    respond_to do |format|
      format.html # fix.html.erb
      format.json { render json: @static_roads }
    end
  end

end
