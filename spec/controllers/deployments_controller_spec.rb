require 'rails_helper'
require 'shared_examples/controllers'

RSpec.describe DeploymentsController, type: :controller do
  login_user

  let(:template) { FactoryGirl.create(:template, user: user) }
  let(:deployment) { FactoryGirl.create(:deployment, template: template) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:deployment, template: template) }
  let(:invalid_attributes) { { template_id: '' } }
  let(:valid_session) { {} }

  describe 'GET #all' do
    it 'assigns all deployments as @deployments' do
      get :all, {}, valid_session
      expect(assigns(:deployments)).to eq([deployment])
    end
  end

  describe 'GET #index' do
    it 'assigns all deployments as @deployments' do
      get :index, { template_id: template.id }, valid_session
      expect(assigns(:deployments)).to eq([deployment])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested deployment as @deployment' do
      get :show, { id: deployment.to_param }, valid_session
      expect(assigns(:deployment)).to eq(deployment)
    end
  end

  describe 'GET #new' do
    it 'assigns a new deployment as @deployment' do
      get :new, { template_id: template.id }, valid_session
      expect(assigns(:deployment)).to be_a_new(Deployment)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Deployment' do
        expect do
          post :create, { deployment: valid_attributes, template_id: template.to_param }, valid_session
        end.to change(Deployment, :count).by(1)
      end

      it 'schedules a new deployment job' do
        expect do
          post :create, { deployment: valid_attributes, template_id: template.to_param }, valid_session
        end.to change(DeploymentJob.jobs, :size).by(1)
      end

      it 'assigns a newly created deployment as @deployment' do
        post :create, { deployment: valid_attributes, template_id: template.to_param }, valid_session
        expect(assigns(:deployment)).to be_a(Deployment)
        expect(assigns(:deployment)).to be_persisted
      end

      it 'redirects to the created deployment' do
        post :create, { deployment: valid_attributes, template_id: template.to_param }, valid_session
        expect(response).to redirect_to(Deployment.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved deployment as @deployment' do
        post :create, { deployment: invalid_attributes, template_id: template.to_param }, valid_session
        expect(assigns(:deployment)).to be_a_new(Deployment)
      end

      it "re-renders the 'new' template" do
        post :create, { deployment: invalid_attributes, template_id: template.to_param }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'POST #options' do
    context 'with valid params' do
      it_behaves_like 'deployment with valid options response'
    end

    context 'with valid provider credentials' do
      describe_regions_exception Aws::EC2::Errors::DryRunOperation
      it_behaves_like 'deployment with valid options response'
    end

    context 'with invalid params' do
      it_behaves_like 'deployment with invalid options', true
    end

    context 'with invalid provider credentials' do
      describe_regions_exception Aws::EC2::Errors::AuthFailure
      it_behaves_like 'deployment with invalid options'
    end

    context 'with generic provider validation failure' do
      before { allow_any_instance_of(Aws::EC2::Client).to receive(:describe_regions).with(dry_run: true).and_raise(StandardError) }
      it_behaves_like 'deployment with invalid options'
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested deployment' do
      id = deployment.to_param
      expect do
        delete :destroy, { id: id, template_id: template.to_param }, valid_session
      end.to change(Deployment, :count).by(-1)
    end

    it 'redirects to the deployments list' do
      delete :destroy, { id: deployment.to_param, template_id: template.to_param }, valid_session
      expect(response).to redirect_to(deployments_url)
    end
  end
end