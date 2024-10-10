<!-- Add this in the <head> section -->
<link rel="manifest" href="{{ asset('manifest.json') }}">

<!-- Add this in the <body> section -->
<script>
    if ('serviceWorker' in navigator) {
        window.addEventListener('load', function() {
            navigator.serviceWorker.register('/sw.js').then(function(registration) {
                console.log('ServiceWorker registration successful with scope: ', registration.scope);
            }).catch(function(error) {
                console.log('ServiceWorker registration failed: ', error);
            });
        });
    }
</script>
