<?php
class ControllerCommonForgotten extends Controller {
	private $error = array();

	public function index() {
                //exit(DB_DATABASE." value of ");
		if ($this->user->isLogged() && isset($this->request->get['token']) && ($this->request->get['token'] == $this->session->data['token'])) {
			$this->response->redirect($this->url->link('common/dashboard', '', true));
		}

		if (!$this->config->get('config_password')) {
			$this->response->redirect($this->url->link('common/login', '', true));
		}

		$this->load->model('user/user');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
		
			$code = token(40);

			$this->model_user_user->editCode($this->request->post['email'], $code);

			$subject = $this->config->get('config_name')." - Password reset request";
			
			$message="A new password was requested for ".$this->config->get('config_name')." administration.\n\n To reset your password click on the link below: ".$this->url->link('common/reset', 'code=' . $code, true)."\n\n The IP used to make this request was: ".$this->request->server['REMOTE_ADDR'];					
				
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->request->post['email']);
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
			$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
			$mail->send();

			$this->session->data['success'] = 'An email with a confirmation link has been sent your email address';

			$this->response->redirect($this->url->link('common/login', '', true));
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['action'] = $this->url->link('common/forgotten', '', true);

		$data['cancel'] = $this->url->link('common/login', '', true);

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} else {
			$data['email'] = '';
		}
                
                if (isset($this->request->post['account'])) {
			$data['account'] = $this->request->post['account'];
		} else {
			$data['account'] = '';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('common/forgotten', $data));
	}

	protected function validate() {
		if (!isset($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_email');
		} elseif (!$this->model_user_user->getTotalUsersByEmail($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_email');
		}

		return !$this->error;
	}
}