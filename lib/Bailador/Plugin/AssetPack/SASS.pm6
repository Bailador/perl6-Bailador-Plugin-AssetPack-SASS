unit class Bailador::Plugin::AssetPack::SASS;

use Bailador;

method install {
    get rx{ ^ '/assets/' (.+) } => sub ($asset) {
        my $file = $*SPEC.catdir: 'assets', $*SPEC.splitdir($asset)
            .grep({ $_ ~~ $*SPEC.curupdir });

        return status 404 unless $file.IO.f;
        content_type $MIME.type($file.IO.extension) // 'application/octet-stream';
        return $file.IO.slurp: :bin;
    };
}
