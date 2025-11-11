{
	environment.etc = {
		"ssh/sshd_config.d/90-nwl-nix.conf" = {
			text = ''
				AllowAgentForwarding yes
				AllowTcpForwarding yes
			'';
		};
	};
}