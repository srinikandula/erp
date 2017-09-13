<?php
abstract class Controller {
	protected $registry;
	public $globalVal;

	public function __construct($registry) {
		$this->registry = $registry;
		$this->globalVal['todayDateTime']=date('Y-m-d H:i:s');
	}

	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}
}