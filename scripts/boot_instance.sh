gcloud compute --project "charlieegan3-dev" instances create "dev-instance" --zone "europe-west3-b" --machine-type "g1-small" --subnet "default" --metadata "startup-scri
pt=curl https://github.com/charlieegan3.keys > /home/charlieegan3/.ssh/authorized_keys" --maintenance-policy "MIGRATE" --no-service-account --no-scopes --image "charlieegan3-dev-1508211725" -
-image-project "charlieegan3-dev" --boot-disk-size "10" --boot-disk-type "pd-standard" --boot-disk-device-name "dev-instance"
