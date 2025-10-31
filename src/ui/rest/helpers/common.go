package helpers

import (
	"context"
	"mime/multipart"
	"time"

	"github.com/sirupsen/logrus"
	domainApp "github.com/aldinokemal/go-whatsapp-web-multidevice/domains/app"
	"go.mau.fi/whatsmeow"
)

func SetAutoConnectAfterBooting(service domainApp.IAppUsecase) {
	time.Sleep(2 * time.Second)
	_ = service.Reconnect(context.Background())
}

func SetAutoReconnectChecking(cli *whatsmeow.Client) {
	// Run every 30 seconds to check if the connection is still alive, if not, reconnect
	go func() {
		for {
			time.Sleep(30 * time.Second)
			if !cli.IsConnected() {
				logrus.Info("[AUTO-RECONNECT] Connection lost, attempting to reconnect...")
				if err := cli.Connect(); err != nil {
					logrus.Errorf("[AUTO-RECONNECT] Failed to reconnect: %v", err)
				} else {
					logrus.Info("[AUTO-RECONNECT] Successfully reconnected")
				}
			} else {
				// Send periodic presence to keep connection alive (every 5 minutes)
				// This helps prevent idle disconnections
				// Note: WhatsApp handles pings internally, this is just extra safety
			}
		}
	}()
}

func MultipartFormFileHeaderToBytes(fileHeader *multipart.FileHeader) []byte {
	file, _ := fileHeader.Open()
	defer file.Close()

	fileBytes := make([]byte, fileHeader.Size)
	_, _ = file.Read(fileBytes)

	return fileBytes
}
