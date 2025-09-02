<?php include_once("./config/config.php") ?>


<!DOCTYPE html>
<html lang="fr">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>LAMP STACK</title>
</head>

<style type="text/css">
	* {
		margin: 0;
		padding: 0;
	}

	html {
		background: #fff;
	}

	body {
		font-family: "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Fira Sans", "Droid Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 1rem;
		font-weight: 400;
		line-height: 1.5;
	}

	#proj {
		width: 70%;
		display: flex;
		flex-direction: row;
		justify-content: space-around;
		
	}

	#hautpage {
		background-color: #209cee;
		color: white;
		background-image: linear-gradient(141deg, #04a6d7 0, #209cee 71%, #3287f5 100%);
	}

	.title {
		font-size: 2rem;
		font-weight: 600;
		line-height: 1.5;
	}

	.subtitle {
		font-size: 1.25rem;
		font-weight: 400;
		line-height: 1.25;
	}

	.content {
		font-size: 1.3rem;
		font-weight: normal;
		margin-bottom: 0.75rem;
	}

	@media screen and (min-width: 1472px) {
		.container {
			max-width: 1344px;
			width: 1344px;
		}
	}

	@media screen and (min-width: 1280px) {
		.container {
			max-width: 1152px;
			width: 1152px;
		}
	}

	@media screen and (min-width: 1088px) {
		.container {
			max-width: 960px;
			width: 960px;
		}
	}

	.container {
		margin: 0 auto;
		position: relative;
	}

	.has-text-centered {
		text-align: center !important;
	}

	@media screen and (min-width: 769px),
	print {
		.hero.is-medium .hero-body {
			padding-bottom: 3rem;
			padding-top: 3rem;
		}
	}

	.hero-body {
		flex-grow: 1;
		flex-shrink: 0;
		padding: 1rem 1.5rem;
	}

	.environnement {
		font-size: .95em;
		margin-top: 20px;
	}

	ul.projects,
	ul.tools {
		list-style: none;
		line-height: 24px;
	}

	ul.projects a,
	ul.tools a {
		padding-left: 22px;
		background: url(index.php?img=pngFolder) 0 100% no-repeat;
		background-size: 16px 16px;
	}

	a {
		color: #777;
		text-decoration: none;
	}

	a:hover {
		color: #000;
		text-decoration: underline;
	}

	.section {
		padding: 3rem 1.5rem;
		min-height: 40vh;
	}

	.footer {
		background-color: #fafafa;
		padding: 3rem 1.5rem 6rem;
		font-size: 1rem;
		font-weight: normal;
	}
</style>


<body>
	<section id="hautpage" class="hero is-medium is-info is-bold">
		<div class="hero-body">
			<div class="container has-text-centered">
				<h1 class="title">
					Serveur LAMP dockerisé
				</h1>
				<h2 class="subtitle">
					BTS SIO Chantilly
				</h2>
				<div class="environnement">
					<p><?= apache_get_version(); ?></p>
					<p>PHP <?= phpversion(); ?></p>
					<p>
						<?php
						try {
							$database = 'mysql:host=database:' . DB_PORT;
							$pdo = new PDO($database, ROOT_DB_USER, ROOT_DB_PWD);
							printf("%s", $pdo->query('select version()')->fetchColumn());
						} catch (PDOException $e) {
							echo "Error: Impossible de se connecter à MySQL. Error:\n $e";
						}
						$pdo = null;
						?>
					</p>
				</div>
			</div>
		</div>
	</section>

	<?php
	// recuperation des projets
	$handle = opendir(".");
	$projectContents = '';
	while ($file = readdir($handle)) :
		if (is_dir($file)) :
			if ($file == '.') echo '';
			else if ($file == '..') echo '';
			else if ($file == 'assets') echo '';
			else if ($file == 'config') echo '';
			else {
				$style = '';
				if (file_exists($file . '/favicon.ico')) {
					$style = ' style="background-image:url(' . $file . '/favicon.ico);background-repeat: no-repeat"';
				} else {
					$style = ' style="background-image:url(./assets/images/default.png);background-repeat: no-repeat"';
				}
				$projectContents .= '<li><a href="' . $file . '"' . $style . '>' . $file . '</a></li>';
			}
		endif;
	endwhile;
	closedir($handle);
	if (!isset($projectContents)) $projectContents = 'Aucun projets';
	?>

	<div class="container section">
		<div id="proj">
			<div>
				<h2 class="content">Projets</h2>
				<ul class="projects">
					<?= $projectContents ?>
				</ul>
			</div>
			<div>
				<h2 class="content">Accès rapides</h2>
				<ul class="tools">
					<li><a href="phpinfo.php" target="_blank" style="background-image:url(./assets/images/tools.png);">phpinfo()</a></li>
					<li><a href="xdebuginfo.php" target="_blank" style="background-image:url(./assets/images/tools.png);">xdebug_info()</a></li>
					<li><a href="http://localhost:8080/" target="_blank" style="background-image:url(./assets/images//phpmyadmin.png);">phpmyadmin</a></li>
				</ul>
			</div>
		</div>
	</div>

	<footer class="footer">
		<div class="has-text-centered">
			<p> @2025 SIO Jean Rostand Chantilly </p>
		</div>
	</footer>
</body>

</html>