class ComputersController < ApplicationController
  # GET /computers
  # GET /computers.xml
  def index
    @computers = Computer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @computers }
    end
  end

  # GET /computers/1
  # GET /computers/1.xml
  def show
    @computer = Computer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @computer }
    end
  end

  # GET /computers/new
  # GET /computers/new.xml
  def new
    @computer = Computer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @computer }
    end
  end

  # GET /computers/1/edit
  def edit
    @computer = Computer.find(params[:id])

    render :partial => 'edit'
  end

  # POST /computers
  # POST /computers.xml
  def create
    @computer = Computer.new(params[:computer])

    respond_to do |format|
      if @computer.save
        flash[:notice] = 'Computer was successfully created.'
        format.html { redirect_to(root_url) }
        format.xml  { render :xml => @computer, :status => :created, :location => @computer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @computer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /computers/1
  # PUT /computers/1.xml
  def update
    @computer = Computer.find(params[:id])

    respond_to do |format|
      if @computer.update_attributes(params[:computer])
        flash[:notice] = 'Comuter was successfully updated.'
        format.html { redirect_to(@computer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @computer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /computers/1
  # DELETE /computers/1.xml
  def destroy
    @computer = Computer.find(params[:id])
    @computer.destroy

    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end

  def inline_edit
    @computer = Computer.find(params[:id])

    render :partial => 'edit'
  end

  def search
    @computers = Computer.search(params[:search])

    if @computers.count == 0
      if params[:search] =~ /^([0-9a-f]{2}(:|$)){6}$/i
        @computer = Computer.new
        @mac_address = params[:search].downcase
        render :partial => 'new'
      else
        render :partial => 'none'
      end
    elsif @computers.count == 1
      @computer = @computers[0]
      render :partial => 'show'
    else
      render :partial => 'computers'
    end
  end
end
